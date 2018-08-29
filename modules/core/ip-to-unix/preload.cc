#include <climits>
#include <csignal>
#include <cstring>
#include <forward_list>
#include <queue>
#include <tuple>
#include <unordered_map>
#include <variant>

#include <arpa/inet.h>
#include <dlfcn.h>
#include <fcntl.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/un.h>
#include <unistd.h>

#ifdef SOCKET_ACTIVATION
#include <systemd/sd-daemon.h>
#endif

typedef std::tuple<int, int, void*, socklen_t> so_cachentry_t;
typedef std::queue<so_cachentry_t> so_cachentries_t;
typedef std::tuple<int, int, so_cachentries_t*> so_cache_val_t;
typedef std::unordered_map<int, so_cache_val_t> so_cache_t;

enum class rule_ip_type { TCP, UDP };
enum class rule_direction { INCOMING, OUTGOING };

typedef struct {
    rule_direction direction;
    std::optional<rule_ip_type> type;
    std::optional<std::string> address;
    std::optional<uint16_t> port;
    bool socket_activation;
    std::optional<std::string> fd_name;
    std::optional<std::string> socket_path;
} udsmap_rule_t;

static const std::forward_list<udsmap_rule_t> udsmap_rules = {
#include UDSMAP_RULE_FILE
};

typedef struct {
    int socktype;
    int protocol;
    std::string sockpath;
    struct in_addr addr;
    in_port_t port;
    const udsmap_rule_t *rule;
    std::queue<std::tuple<int, int, void*, socklen_t>> sockopts;
} udsmap_sockinfo_t;

typedef struct {
    udsmap_sockinfo_t *parent;
} udsmap_sockchild_t;

typedef std::variant<udsmap_sockinfo_t*, udsmap_sockchild_t> sockentry_t;
static std::unordered_map<int, sockentry_t> active_sockets;

typedef int (*socket_fun_t) (int, int, int);
typedef int (*setsockopt_fun_t) (int, int, int, const void*, socklen_t);
typedef int (*bind_fun_t) (int, const struct sockaddr*, socklen_t);
typedef int (*connect_fun_t) (int, const struct sockaddr*, socklen_t);
#ifdef SOCKET_ACTIVATION
typedef int (*listen_fun_t) (int, int);
#endif
typedef int (*accept_fun_t) (int, struct sockaddr*, socklen_t*);
typedef int (*accept4_fun_t) (int, struct sockaddr*, socklen_t*, int);
typedef int (*getpeername_fun_t) (int, struct sockaddr*, socklen_t*);
typedef int (*getsockname_fun_t) (int, struct sockaddr*, socklen_t*);
typedef int (*close_fun_t) (int);

#define DLSYM_FUN(name, ...) \
    static name##_fun_t _##name = nullptr; \
    if (_##name == nullptr) \
        _##name = (name##_fun_t)dlsym(RTLD_NEXT, #name); \
    return _##name(__VA_ARGS__)

static inline std::optional<sockentry_t> get_active_socket(int fd)
{
    auto found = active_sockets.find(fd);
    if (found == active_sockets.end())
        return std::nullopt;
    return found->second;
}

static inline udsmap_sockinfo_t *get_parent(sockentry_t &se)
{
    if (std::holds_alternative<udsmap_sockinfo_t*>(se))
        return std::get<udsmap_sockinfo_t*>(se);
    else
        return std::get<udsmap_sockchild_t>(se).parent;
}

static inline bool is_children(sockentry_t &se)
{
    return std::holds_alternative<udsmap_sockchild_t>(se);
}

#ifdef SOCKET_ACTIVATION
static inline bool is_socket_activated(int fd)
{
    auto found = active_sockets.find(fd);
    return found != active_sockets.end()
        && get_parent(found->second)->rule->socket_activation;
}
#endif

static int real_socket(int domain, int type, int protocol)
{
    DLSYM_FUN(socket, domain, type, protocol);
}

static int real_setsockopt(int sockfd, int level, int optname,
                           const void *optval, socklen_t optlen)
{
    DLSYM_FUN(setsockopt, sockfd, level, optname, optval, optlen);
}

static int real_bind(int fd, const struct sockaddr *addr, socklen_t addrlen)
{
    DLSYM_FUN(bind, fd, addr, addrlen);
}

static int real_connect(int fd, const struct sockaddr *addr, socklen_t addrlen)
{
    DLSYM_FUN(connect, fd, addr, addrlen);
}

static inline int real_bind_connect(rule_direction dir, int fd,
                                    const struct sockaddr *addr,
                                    socklen_t addrlen)
{
    switch (dir) {
        case rule_direction::INCOMING:
            return real_bind(fd, addr, addrlen);
        case rule_direction::OUTGOING:
            return real_connect(fd, addr, addrlen);
    }
    return -1;
}

static int real_accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen)
{
    DLSYM_FUN(accept, sockfd, addr, addrlen);
}

static int real_accept4(int sockfd, struct sockaddr *addr, socklen_t *addrlen,
                        int flags)
{
    DLSYM_FUN(accept4, sockfd, addr, addrlen, flags);
}

static int real_getpeername(int fd, struct sockaddr *addr, socklen_t *addrlen)
{
    DLSYM_FUN(getpeername, fd, addr, addrlen);
}

static int real_getsockname(int fd, struct sockaddr *addr, socklen_t *addrlen)
{
    DLSYM_FUN(getsockname, fd, addr, addrlen);
}

#ifdef SOCKET_ACTIVATION
static int real_listen(int sockfd, int backlog)
{
    DLSYM_FUN(listen, sockfd, backlog);
}
#endif

static int real_close(int fd)
{
    DLSYM_FUN(close, fd);
}

static bool match_sockaddr_in(const struct sockaddr_in *addr,
                              udsmap_rule_t rule)
{
    /* Use max size of INET6 address, because INET is shorter anyway. */
    char buf[INET6_ADDRSTRLEN];
    bool match = true;

    if (rule.address &&
        inet_ntop(addr->sin_family, &addr->sin_addr, buf,
                  sizeof(buf)) != nullptr) {
        if (std::string(buf) != rule.address.value())
            match = false;
    }

    if (rule.port && ntohs(addr->sin_port) != rule.port.value())
        match = false;

    return match;
}

static bool match_sotype(int type, udsmap_rule_t rule)
{
    if (!rule.type)
        return true;

    switch (type) {
        case SOCK_STREAM:
            return rule.type.value() == rule_ip_type::TCP;
        case SOCK_DGRAM:
            return rule.type.value() == rule_ip_type::UDP;
    }

    return false;
}

int socket(int domain, int type, int protocol)
{
    int fd = real_socket(domain, type, protocol);
    if (domain == AF_INET || domain == AF_INET6) {
        udsmap_sockinfo_t *si = new udsmap_sockinfo_t();
        si->socktype = type;
        si->protocol = protocol;
        memset(&si->addr, 0, sizeof(struct in_addr));
        memset(&si->port, 0, sizeof(in_port_t));
        active_sockets[fd] = si;
    }
    return fd;
}

/*
 * We override setsockopt() so that we can gather all the socket options that
 * are set for the socket file descriptor in question.
 */
int setsockopt(int sockfd, int level, int optname, const void *optval,
               socklen_t optlen)
{
    auto si = get_active_socket(sockfd);
    /* Only cache socket options for SOL_SOCKET, no IPPROTO_TCP etc... */
    if (si && level == SOL_SOCKET) {
        void *optcopy = ::operator new(optlen);
        memcpy(optcopy, optval, optlen);
        auto entry = std::make_tuple(level, optname, optcopy, optlen);
        get_parent(si.value())->sockopts.push(entry);
    }
    return real_setsockopt(sockfd, level, optname, optval, optlen);
}

/*
 * Set all the socket options and file descriptor flags from old_sockfd to
 * new_sockfd.
 */
static bool set_cached_sockopts(int old_sockfd, int new_sockfd)
{
    int fdflags, fdstatus;

    if ((fdflags = fcntl(old_sockfd, F_GETFD)) == -1) {
        perror("fcntl(F_GETFD)");
        return false;
    }

    if ((fdstatus = fcntl(old_sockfd, F_GETFL)) == -1) {
        perror("fcntl(F_GETFL)");
        return false;
    }

    if (fcntl(new_sockfd, F_SETFD, fdflags) == -1) {
        perror("fcntl(F_SETFD)");
        return false;
    }

    if (fcntl(new_sockfd, F_SETFL, fdstatus) == -1) {
        perror("fcntl(F_SETFL)");
        return false;
    }

    auto si = get_active_socket(old_sockfd);
    if (si) {
        auto sockinfo = get_parent(si.value());
        while (!sockinfo->sockopts.empty()) {
            auto entry = sockinfo->sockopts.front();
            if (real_setsockopt(new_sockfd, std::get<0>(entry),
                                std::get<1>(entry), std::get<2>(entry),
                                std::get<3>(entry)) == -1) {
                perror("setsockopt");
                return false;
            }
            sockinfo->sockopts.pop();
        }
    }

    return true;
}

/*
 * Turn the given socket file descriptor into a UNIX Domain socket by creating
 * a new socket and setting all the socket options and file descriptor flags
 * from the old socket.
 *
 * The socket options are read from sockopt_cache, which is gathered from the
 * override of the setsockopt() function above.
 */
static bool sock_make_unix(int old_sockfd)
{
    int sockfd;

    auto si = get_parent(active_sockets[old_sockfd]);

    if ((sockfd = real_socket(AF_UNIX, si->socktype, 0)) == -1) {
        perror("socket(AF_UNIX)");
        return false;
    }

    if (!set_cached_sockopts(old_sockfd, sockfd)) {
        real_close(sockfd);
        return false;
    }

    if (dup2(sockfd, old_sockfd) == -1) {
        perror("dup2");
        real_close(sockfd);
        return false;
    }

    return true;
}

#ifdef SOCKET_ACTIVATION
/*
 * Get a systemd socket file descriptor for the given rule either via name if
 * fd_name is set or just the next file descriptor available.
 */
static int get_systemd_fd_for_rule(udsmap_rule_t rule)
{
    static std::unordered_map<std::string, int> names;
    static std::queue<int> fds;
    static bool fetch_done = false;

    if (!fetch_done) {
        char **raw_names = nullptr;
        int count = sd_listen_fds_with_names(1, &raw_names);
        if (count < 0) {
            fprintf(stderr, "FATAL: Unable to get systemd sockets: %s\n",
                    strerror(errno));
            std::abort();
        } else if (count == 0) {
            fputs("FATAL: Needed at least one systemd socket file descriptor,"
                  " but found zero.\n", stderr);
            std::abort();
        }
        for (int i = 0; i < count; ++i) {
            std::string name = raw_names[i];
            if (name.empty() || name == "unknown" || name == "stored")
                fds.push(SD_LISTEN_FDS_START + i);
            else
                names[name] = SD_LISTEN_FDS_START + i;
        }
        if (raw_names != nullptr)
            free(raw_names);
        fetch_done = true;
    }

    if (rule.fd_name) {
        auto found = names.find(rule.fd_name.value());
        if (found == names.end()) {
            fprintf(stderr, "FATAL: Can't get systemd socket for '%s'.\n",
                    rule.fd_name.value().c_str());
            std::abort();
        }
        return found->second;
    } else if (fds.empty()) {
        fputs("FATAL: Ran out of systemd sockets to assign\n", stderr);
        std::abort();
    }

    int fd = fds.front();
    fds.pop();
    return fd;
}

/*
 * For systemd socket activation, we need to make sure the program doesn't run
 * listen on the socket, as this is already done by systemd.
 */
int listen(int sockfd, int backlog)
{
    if (is_socket_activated(sockfd))
        return 0;
    else
        return real_listen(sockfd, backlog);
}
#endif

/*
 * Handle both bind() and connect() depending on the value of "dir".
 */
static inline int handle_bind_connect(rule_direction dir, int fd,
                                      const struct sockaddr *addr,
                                      socklen_t addrlen)
{
    if (addr->sa_family != AF_INET && addr->sa_family != AF_INET6)
        return real_bind_connect(dir, fd, addr, addrlen);

    for (auto &rule: udsmap_rules) {
        if (rule.direction != dir)
            continue;

        if (!match_sockaddr_in((struct sockaddr_in*)addr, rule))
            continue;

        auto found = active_sockets.find(fd);
        if (found == active_sockets.end())
            continue;

        udsmap_sockinfo_t *si = get_parent(found->second);

        if (!match_sotype(si->socktype, rule))
            continue;

#ifdef SOCKET_ACTIVATION
        if (rule.socket_activation) {
            int newfd = get_systemd_fd_for_rule(rule);

            if (!set_cached_sockopts(fd, newfd))
                return -1;

            if (dup2(newfd, fd) == -1) {
                perror("dup2");
                return -1;
            }

            struct sockaddr_in *inaddr = (struct sockaddr_in *)addr;
            memcpy(&si->addr, &inaddr->sin_addr, sizeof(struct in_addr));
            memcpy(&si->port, &inaddr->sin_port, sizeof(in_port_t));

            si->rule = &rule;
            return 0;
        }
#endif
        if (!rule.socket_path)
            continue;

        if (!sock_make_unix(fd))
            continue;

        struct sockaddr_un ua;
        memset(&ua, 0, sizeof ua);
        ua.sun_family = AF_UNIX;
        strcpy(ua.sun_path, rule.socket_path.value().c_str());

        int ret = real_bind_connect(dir, fd, (struct sockaddr*)&ua, sizeof ua);
        if (ret == 0) {
            struct sockaddr_in *inaddr = (struct sockaddr_in *)addr;
            memcpy(&si->addr, &inaddr->sin_addr, sizeof(struct in_addr));
            memcpy(&si->port, &inaddr->sin_port, sizeof(in_port_t));
            si->rule = &rule;
        }
        return ret;
    }

    return real_bind_connect(dir, fd, addr, addrlen);
}

int bind(int fd, const struct sockaddr *addr, socklen_t addrlen)
{
    return handle_bind_connect(rule_direction::INCOMING, fd, addr, addrlen);
}

int connect(int fd, const struct sockaddr *addr, socklen_t addrlen)
{
    return handle_bind_connect(rule_direction::OUTGOING, fd, addr, addrlen);
}

static void set_peername(struct sockaddr *addr, socklen_t *addrlen)
{
    struct sockaddr_in dummy;
    dummy.sin_family = AF_INET;
    dummy.sin_addr.s_addr = inet_addr("127.0.0.1");
    // TODO: Rotate this!
    dummy.sin_port = htons(65530);
    memcpy(addr, &dummy, sizeof dummy);
    *addrlen = sizeof dummy;
}

int accept(int fd, struct sockaddr *addr, socklen_t *addrlen)
{
    int accfd = real_accept(fd, addr, addrlen);
    if (accfd > 0) {
        auto si = get_active_socket(fd);
        if (si) {
            udsmap_sockchild_t newchild;
            newchild.parent = get_parent(si.value());
            active_sockets[accfd] = newchild;
            set_peername(addr, addrlen);
        }
    }
    return accfd;
}

int accept4(int fd, struct sockaddr *addr, socklen_t *addrlen, int flags)
{
    int accfd = real_accept4(fd, addr, addrlen, flags);
    if (accfd > 0) {
        auto si = get_active_socket(fd);
        if (si) {
            udsmap_sockchild_t newchild;
            newchild.parent = get_parent(si.value());
            active_sockets[accfd] = newchild;
            set_peername(addr, addrlen);
        }
    }
    return accfd;
}

int getpeername(int fd, struct sockaddr *addr, socklen_t *addrlen)
{
    auto found = get_active_socket(fd);
    if (found) {
        set_peername(addr, addrlen);
        return 0;
    }
    return real_getpeername(fd, addr, addrlen);
}

int getsockname(int fd, struct sockaddr *addr, socklen_t *addrlen)
{
    auto found = get_active_socket(fd);
    if (found) {
        auto si = get_parent(found.value());

        struct sockaddr_in inaddr;
        inaddr.sin_family = AF_INET;
        memcpy(&inaddr.sin_addr, &si->addr, sizeof(struct in_addr));
        memcpy(&inaddr.sin_port, &si->port, sizeof(in_port_t));
        memcpy(addr, &inaddr, sizeof inaddr);
        *addrlen = sizeof inaddr;
        return 0;
    }
    return real_getsockname(fd, addr, addrlen);
}

int close(int fd)
{
    auto found = get_active_socket(fd);
    if (!found || is_children(found.value())) {
        return real_close(fd);
    } else {
        auto si = get_parent(found.value());
#ifdef SOCKET_ACTIVATION
        if (si->rule->socket_activation) {
            active_sockets.erase(fd);
            return 0;
        }
#endif
        int ret = real_close(fd);

        std::optional<std::string> sockpath = si->rule->socket_path;
        if (sockpath && si->rule->direction == rule_direction::INCOMING)
            unlink(sockpath.value().c_str());
        active_sockets.erase(fd);
        return ret;
    }
}

extern char **environ;

int main(int argc, char *argv[])
{
    char self[PATH_MAX], *preload;
    ssize_t len;

    if ((len = readlink("/proc/self/exe", self, sizeof(self) - 1)) == -1) {
        perror("readlink(\"/proc/self/exe\")");
        return EXIT_FAILURE;
    }

    self[len] = '\0';

    if ((preload = getenv("LD_PRELOAD")) != nullptr && *preload != '\0') {
        std::string new_preload = std::string(self) + ":" + preload;
        setenv("LD_PRELOAD", new_preload.c_str(), 1);
    } else {
        setenv("LD_PRELOAD", self, 1);
    }

    if (execve(PROGRAM_PATH, argv, environ) == -1)
        perror("execve(" PROGRAM_PATH ")");

    return EXIT_FAILURE;
}
