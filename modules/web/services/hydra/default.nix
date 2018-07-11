{ config, toplevel, pkgs, lib, mkUnique, mkUniqueUser, mkUniqueGroup, ... }:

let
  nix = toplevel.config.nix.package.overrideAttrs (drv: {
    # This patch allows pass a --store argument to nix-daemon.
    patches = (drv.patches or []) ++ lib.singleton (pkgs.fetchpatch {
      url = "https://github.com/NixOS/nix/commit/"
          + "e388739098cfb14a166923cd24b6140674b176f8.patch";
      sha256 = "0mh328ff9p6np1iw70lkrvsiwr10y6y3dqj6mq47w0y4n38vimck";
    });

    # XXX: We can't easily .override nix.perl-bindings, so it's copy & pasted
    # from <nixpkgs/pkgs/tools/package-management/nix/default.nix>.
    passthru.perl-bindings = pkgs.stdenv.mkDerivation {
      name = "nix-perl-" + nix.version;

      inherit (nix) src;

      postUnpack = "sourceRoot=$sourceRoot/perl";

      nativeBuildInputs = [
        pkgs.perl pkgs.pkgconfig pkgs.curl nix pkgs.libsodium pkgs.boost
      ];

      configureFlags = with pkgs.perl; [
        "--with-dbi=${pkgs.perlPackages.DBI}/${libPrefix}"
        "--with-dbd-sqlite=${pkgs.perlPackages.DBDSQLite}/${libPrefix}"
      ];

      preConfigure = "export NIX_STATE_DIR=$TMPDIR";

      preBuild = "unset NIX_INDENT_MAKE";

    };
  });

  gcRootsDir = let
    mainPath = "/nix/var/nix/gcroots/${mkUnique "hydra"}";
    pre = lib.optionalString config.useSeparateStore "${config.stateDir}/root";
  in pre + mainPath;

  # Patch Hydra so that it uses nix dump-path with a --store argument.
  # Unfortunately we can't simply use the store_uri because that would bypass
  # the Nix daemon in other places.
  #
  # I'm using HYDRA_NIX_STORE_ROOT as an environment variable here so that we
  # don't need to rebuild Hydra every time we add a new instance.
  hydra = (config.package.override { inherit nix; }).overrideAttrs (drv: {
    postPatch = ''
      substituteInPlace src/lib/Hydra/View/NixNAR.pm \
        --replace "nix-store --dump" \
                  "nix dump-path --store '\$ENV{HYDRA_NIX_STORE_ROOT}'"
    '';
  });

  hydraEnv = {
    # XXX: Remove this!
    HYDRA_NIX_STORE_ROOT = "daemon";

    HYDRA_DBI = "dbi:Pg:dbname=hydra;user=${mkUniqueUser "hydra"};"
              + "host=${config.database.hydra.socketPath}";
    # TODO: gc_roots_dir!
    HYDRA_CONFIG = let
      inherit (config.proxyOptions) domain path;
      inherit (toplevel.config.nixcloud.reverse-proxy) httpPort httpsPort;
      isHttps = config.proxyOptions.https.mode != "off";
      scheme = if isHttps then "https" else "http";
      # XXX: This really should be passed through by the either the reverse
      # proxy or some common interface in the core of the webservices.
      maybePort = let
        mkMaybePort = p: d: lib.optionalString (p != d) ":${toString p}";
        maybeHttpPort = mkMaybePort httpPort 80;
        maybeHttpsPort = mkMaybePort httpsPort 443;
      in if isHttps then maybeHttpsPort else maybeHttpPort;
      baseURI = "${scheme}://${domain}${maybePort}${path}";
    in pkgs.writeText "hydra.conf" (''
      using_frontend_proxy = 1
      base_uri = ${baseURI}
      max_servers = 25
      compress_num_threads = 0
      use-substitutes = ${if config.useSubstitutes then "1" else "0"}
      gc_roots_dir = ${gcRootsDir}
    '' + lib.optionalString config.useSeparateStore ''
      store_uri = unix://${config.runtimeDir}/nix-daemon.socket
    '');
    HYDRA_DATA = config.stateDir;
    IN_SYSTEMD = "1"; # To get log severity levels for the journal
  } // lib.optionalAttrs config.useSeparateStore {
    # XXX: Remove this!
    HYDRA_NIX_STORE_ROOT = "unix://${config.runtimeDir}/nix-daemon.socket";

    NIX_REMOTE = "unix://${config.runtimeDir}/nix-daemon.socket";
    NIX_STATE_DIR = "${config.stateDir}/root/nix/var/nix";
  };

in {
  options = {
    package = lib.mkOption {
      type = lib.types.path;
      default = pkgs.hydra;
      description = "The Hydra package to use.";
    };

    useSeparateStore = lib.mkOption {
      type = lib.types.bool;
      default = false; # TODO: Set to true once store separation is working.
      description = ''
        Set this to <literal>true</literal> if you want to have a separate Nix
        store from the main one in <filename
        class="directory">/nix/store</filename>.
      '';
    };

    useSubstitutes = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to use binary caches for downloading store paths. Note that
        binary substitutions trigger (a potentially large number of) additional
        HTTP requests that slow down the queue monitor thread significantly.
        Also, this Hydra instance will serve those downloaded store paths to
        its users with its own signature attached as if it had built them
        itself, so don't enable this feature unless your active binary caches
        are absolute trustworthy.
      '';
    };

    initialAdminUser = lib.mkOption {
      type = lib.types.str;
      default = "admin";
      description = ''
        The initial user to create which has administrative privileges and can
        create more users.
      '';
    };

    initialAdminPassword = lib.mkOption {
      type = lib.types.str;
      description = ''
        The password of the initial admin user specified by
        <option>initialAdminUser</option>.

        <note><para>This password will be placed into the Nix store, which is
        readable by all users of the system. Even though it will be stored
        there in hashed form, it's not salted so be sure to change it as soon
        as possible.</para></note>
      '';
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.enable {
      groups.hydra = {};

      users.hydra = {
        description = "Hydra";
        group = "hydra";
        createHome = true;
        home = config.stateDir;
      };

      users.hydra-queue-runner = {
        description = "Hydra queue runner";
        group = "hydra";
        createHome = true;
        home = "${config.stateDir}/queue-runner";
      };

      users.hydra-www = {
        description = "Hydra web server";
        createHome = true;
        group = "hydra";
        home = "${config.stateDir}/www";
      };

      directories.build-logs = {
        owner = mkUniqueUser "hydra-queue-runner";
        group = mkUniqueGroup "hydra";
        permissions.others.noAccess = true;
      };

      # Hydra only supports PostgreSQL
      database.hydra.type = "postgresql";
      database.hydra.owners = [ "hydra-queue-runner" "hydra-www" ];

      systemd.services.hydra-init = {
        description = "Hydra Initialisation";
        environment = hydraEnv;
        instance.after = [ "database.target" ];
        serviceConfig.ExecStart = "${hydra}/bin/hydra-init";
        serviceConfig.User = "hydra";
        serviceConfig.Type = "oneshot";
        serviceConfig.RemainAfterExit = true;

        postStart = let
          hashedPw = builtins.hashString "sha1" config.initialAdminPassword;
        in ''
          if [ ! -e ${lib.escapeShellArg config.stateDir}/.init-done ]; then
            ${lib.escapeShellArg hydra}/bin/hydra-create-user \
              ${lib.escapeShellArg config.initialAdminUser} \
              --password-hash ${lib.escapeShellArg hashedPw} \
              --role admin

            touch ${lib.escapeShellArg config.stateDir}/.init-done
          fi
        '';
      };

      systemd.services.hydra-init-gcroots = {
        description = "Hydra GC Roots Directory Creation";
        instance.requiredBy = [ "hydra-init.service" ];
        instance.before = [ "hydra-init.service" ];

        serviceConfig.Type = "oneshot";
        script = let
          escRoots = lib.escapeShellArg gcRootsDir;
          userGroup = "${mkUniqueUser "hydra"}:${mkUniqueGroup "hydra"}";
        in ''
          mkdir -p ${escRoots}
          chown ${lib.escapeShellArg userGroup} ${escRoots}
          chmod 2775 ${escRoots}
        '';

        unitConfig.ConditionPathExists = "!${gcRootsDir}";
      };

      systemd.services.hydra-server = {
        description = "Hydra Server";
        wantedBy = [ "multi-user.target" ];

        instance.requires = [ "hydra-init.service" ];
        instance.after = [ "hydra-init.service" ];

        environment = hydraEnv;

        serviceConfig = {
          ExecStart = let
            args = lib.concatMapStringsSep " " lib.escapeShellArg [
              # FIXME: Let's use sockets here once we have support for them in
              #        the reverse proxy.
              "-f" "-h" config.proxyOptions.ip
              "-p" (toString config.proxyOptions.port)
              #"--max_spare_servers" "5" # XXX
              #"--max_servers" "25" # XXX
            ];
          in "@${hydra}/bin/hydra-server hydra-server ${args}";
          User = "hydra-www";
          Restart = "on-failure";
        };
      };

      systemd.services.hydra-queue-runner = {
        description = "Hydra Queue Runner";
        wantedBy = [ "multi-user.target" ];

        instance.requires = [ "hydra-init.service" ];
        instance.after = [ "hydra-init.service" ];

        environment = hydraEnv;
        path = [ hydra pkgs.nettools pkgs.openssh pkgs.bzip2 nix ];

        serviceConfig = {
          ExecStart = "@${hydra}/bin/hydra-queue-runner hydra-queue-runner -v";
          ExecStopPost = "${hydra}/bin/hydra-queue-runner --unlock";
          User = "hydra-queue-runner";
          Restart = "always"; # XXX!
          WorkingDirectory = "~";
        } // lib.optionalAttrs config.useSeparateStore {
          RootDirectory = "${config.stateDir}/root";
          MountFlags = "private";
          MountAPIVFS = true;
          # FIXME: Make more restrictive!
          BindPaths = [ "/tmp" "/var" "/etc" "/run" ];
        };
      };

      # TODO: Make this DRY with the queue runner
      systemd.services.hydra-evaluator = {
        description = "Hydra Evaluator";
        wantedBy = [ "multi-user.target" ];

        instance.requires = [ "hydra-init.service" ];
        instance.after = [ "hydra-init.service" ];

        path = [ hydra pkgs.nettools pkgs.jq ];

        environment = hydraEnv // lib.optionalAttrs config.useSeparateStore {
          NIX_DATA_DIR = "/nix-data";
        };

        serviceConfig = {
          ExecStart = "@${hydra}/bin/hydra-evaluator hydra-evaluator -v";
          ExecStopPost = "${hydra}/bin/hydra-evaluator --unlock";
          User = "hydra";
          Restart = "always"; # XXX!
          WorkingDirectory = "~";
        } // lib.optionalAttrs config.useSeparateStore {
          RootDirectory = "${config.stateDir}/root";
          MountFlags = "private";
          MountAPIVFS = true;
          # FIXME: Make more restrictive!
          BindPaths = [ "/tmp" "/var" "/etc" "/run" ];
          BindReadOnlyPaths = [ "${nix}/share:/nix-data:rbind" ];
        };
      };

      tests.wanted = [ ./test.nix ];
    })
    (lib.mkIf (config.enable && !config.useSeparateStore) {
      toplevel.nix.trustedUsers = [ (mkUniqueGroup "hydra-queue-runner") ];
    })
    (lib.mkIf (config.enable && config.useSeparateStore) {
      directories."/".instance.before = [ "hydra-store-init.service" ];

      # Make sure we don't mess with the permissions needed for the Nix daemon.
      directories.root.instance.before = [ "hydra-store-init.service" ];
      directories.root.permissions.enableACLs = false;
      directories.root.permissions.recursive = false;

      systemd.packages = let
        # Generate a systemd service unit file (will be merged with the NixOS
        # systemd.service options) that bind mounts all the paths that are part
        # of the closure of the the given refs.
        mkBindMounts = refs: serviceName: pkgs.runCommand "bind-mounts" {
          exportReferencesGraph = lib.concatLists (lib.imap0 (num: ref: [
            "closure-${toString num}" ref
          ]) refs);
          serviceName = mkUnique "hydra-${serviceName}.service";
        } ''
          mkdir -p "$out/lib/systemd/system"
          servicePath="$out/lib/systemd/system/$serviceName"
          echo '[Service]' > "$servicePath"

          # Collect all the store paths from the closure-* files and remove
          # duplicates.
          runtimeDeps="$(sed -ne '
            p; n; n
            :cdown
            /^0*$/b
            :l; s/0\(X*\)$/X\1/; tl
            s/^\(X*\)$/9\1/; tdone
            ${lib.concatMapStrings (num: ''
              s/${toString num}\(X*\)$/${toString (num - 1)}\1/; tdone
            '') (lib.range 1 9)}
            :done
            y/X/9/
            x; n; p; x
            bcdown
          ' closure-* | sort -u)"

          for dep in $runtimeDeps; do
            echo "BindReadOnlyPaths=$dep:$dep:rbind"
          done >> "$servicePath"
        '';
      in [
        (mkBindMounts [
          hydra nix pkgs.nettools pkgs.jq hydraEnv.HYDRA_CONFIG
        ] "evaluator")
        (mkBindMounts [
          hydra nix pkgs.nettools pkgs.openssh pkgs.bzip2 hydraEnv.HYDRA_CONFIG
        ] "queue-runner")
      ];

      users = lib.listToAttrs (map (number: {
        name = "nixbld${toString number}";
        value.description = "Nix Build User ${toString number}";
        value.group = "nixbld";
        value.extraGroups = lib.singleton (mkUniqueGroup "nixbld");
      }) (lib.range 1 toplevel.config.nix.nrBuildUsers));

      groups.nixbld = {};

      systemd.sockets.nix-daemon = {
        description = "Socket For Dedicated Nix Daemon";
        instance.requiredBy = [ "hydra-init.service" ];
        instance.before = [ "hydra-init.service" ];
        socketConfig.ListenStream = "${config.runtimeDir}/nix-daemon.socket";
        unitConfig.DefaultDependencies = false;
      };

      systemd.services.nix-daemon = {
        description = "Dedicated Nix Daemon For Hydra";
        instance.after = [ "hydra-store-init.service" ];

        environment.NIX_CONF_DIR = let
          cfg = toplevel.config.nix;
        in pkgs.writeTextDir "nix.conf" ''
          build-users-group = ${mkUniqueGroup "nixbld"}
          max-jobs = ${toString cfg.maxJobs}
          cores = ${toString cfg.buildCores}
          sandbox = true
          substituters = ${toString cfg.binaryCaches}
          trusted-substituters = ${toString cfg.trustedBinaryCaches}
          trusted-public-keys = ${toString cfg.binaryCachePublicKeys}
          auto-optimise-store = ${lib.boolToString cfg.autoOptimiseStore}
          require-sigs = ${lib.boolToString cfg.requireSignedBinaryCaches}
          trusted-users = ${mkUniqueUser "hydra-queue-runner"}
          builders =
          extra-sandbox-paths = ${nix}
        '';
        environment.CURL_CA_BUNDLE = "/etc/ssl/certs/ca-certificates.crt";
        environment.NIX_STATE_DIR = "${config.stateDir}/root/nix/var/nix";

        serviceConfig = {
          ExecStart = "@${nix}/bin/nix-daemon nix-daemon --store "
                    + "${lib.escapeShellArg "${config.stateDir}/root"}";
          KillMode = "process";
          Nice = toplevel.config.nix.daemonNiceLevel;
          IOSchedulingPriority = toplevel.config.nix.daemonIONiceLevel;
          LimitNOFILE = 4096;
        };
      };

      systemd.services.hydra-store-init = {
        description = "Initialise Nix Store For Hydra";
        instance.requiredBy = [ "hydra-init.service" ];
        instance.before = [ "hydra-init.service" ];
        instance.after = [ "hydra-init-gcroots.service" ];

        serviceConfig.Type = "oneshot";
        serviceConfig.ExecStart = "${nix}/bin/nix-store --init";

        environment.NIX_REMOTE = "${config.stateDir}/root";

        unitConfig.ConditionPathExists = "!${config.stateDir}/root/nix";
      };
    })
  ];

  meta.license = lib.licenses.gpl3Plus;
}
