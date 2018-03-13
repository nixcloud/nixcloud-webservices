#!@interpreter@
import os
from pwd import getpwnam
from argparse import ArgumentParser

DBSHELL_CONFIG = @dbshellConfig@ # noqa
WEBSERVICES_PREFIX = "/var/lib/nixcloud/webservices"


def run_shell(dbname, user, command):
    os.setuid(getpwnam(user).pw_uid)
    os.execl(command, command, user, dbname)


def determine_wsname():
    rel_to_ws_dir = os.path.relpath(os.getcwd(), WEBSERVICES_PREFIX)
    components = rel_to_ws_dir.split(os.sep, 1)
    if len(components) != 2:
        return None
    wsname_canidate = components[0]
    if wsname_canidate in [os.curdir, os.pardir]:
        return None
    if wsname_canidate not in DBSHELL_CONFIG:
        return None
    return wsname_canidate


if __name__ == '__main__':
    desc = "Connect to a database within a web service instance"
    parser = ArgumentParser(description=desc)
    parser.add_argument("webservice_name", nargs='?',
                        help="The web service name. If the argument is"
                             " omitted, the service name is determined"
                             " by inspecting the current directory.")
    parser.add_argument("database", help="The database name to connect to.")
    options = parser.parse_args()

    if options.webservice_name is None:
        wsname = determine_wsname()
        if wsname is None:
            parser.error("Unable to determine web service name.")
    elif options.webservice_name not in DBSHELL_CONFIG:
        msg = "Web service {!r} does not exist."
        parser.error(msg.format(options.webservice_name))
    else:
        wsname = options.webservice_name

    wsdef = DBSHELL_CONFIG[wsname]
    if options.database not in wsdef:
        msg = "Database {!r} does not exist for web service {!r}."
        parser.error(msg.format(options.database, wsname))
    else:
        run_shell(options.database, **wsdef[options.database])
