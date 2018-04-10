#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix bash jq
#
# To quickly run a web service you can use the following command:
#
#   nix-build run-webservice.nix -A leaps
#
# If you want to provide more options, you can pass them using --arg and
# wsConfig:
#
#   nix-build run-webservice.nix \
#     --arg wsConfig '{ defaultSkin = "nostalgia" }' \
#     -A mediawiki
#
# The result is script that spawns a QEMU VM and automatically forwards ports
# so that the web service is accessible by pointing your browser at
# http://localhost:3000/. A SSH session is also started and automatically
# connected to the guest VM via the root user.
#
# Emails sent from web services are all caught under the root user's mailbox,
# so simply invoking "mutt" will give you access to all mails that were sent
# out by the web service.
#
# Running the VM is a matter of just executing the resulting store path, which
# by default is "./result".
#
# Note that a file called "nixcloud-dev.qcow2" is created when running the VM,
# which contains the disk state for the guest system. If you want to get rid of
# all state and start fresh, simple delete the file and run again.
set -e
pushd "$(dirname "$0")" > /dev/null

printAvailable() {
  echo "Available web service names are:" >&2
  echo >&2
  eval "$(nix-instantiate --eval --strict --json -E '
    builtins.attrNames (import ./run-webservice.nix {})
  ' | jq -r '@sh "for i in \(.); do echo \"  * $i\" >&2; done"')"
  echo >&2
}

printUsage() {
cat >&2 <<EOF
$0 [options] [--] webservice_name [qemu_args]

This is a helper tool which should aid in development of new modules. It can
also be used to take a quick look at what a web service does and to play around
with it.

To quickly run a web service you can run it like this for the Leaps service:

  $0 leaps

You can also provide more configuration options which are applied to the web
service submodule, for example to change the default skin for MediaWiki:

  $0 -c '{ defaultSkin = "nostalgia"; }' mediawiki

This builds and spawns a QEMU VM and automatically forwards ports so that the
web service is accessible by pointing your browser at http://localhost:3000/.

A SSH session is also started and automatically connected to the guest VM via
the root user.

Emails sent from web services are all caught under the root user's mailbox, so
simply invoking "mutt" will give you access to all mails that were sent out by
the web service.

Note that a file called "nixcloud-dev.qcow2" is created in the current working
directory while the VM is starting up which contains the disk state for the
guest system. If you want to get rid of all state and start fresh, simple
delete the file and run again.

Available options:

  -c|--ws-config       Provide additional configuration values for the given
                       web service.
  -I                   Set a value for the Nix search path.

EOF
printAvailable
}

wsName=""
wsConfig="{}"
declare -a nixBuildOptions=()
options="$(getopt -s bash -n "$0" -l 'help,ws-config:' -o 'hc:I:' -- "$@")"
eval set -- "$options"

while :; do
  case "$1" in
    -I)
      nixBuildOptions+=("$1" "$2")
      shift
      ;;
    -h|--help)
      printUsage
      exit 1
      ;;
    -c|--ws-config)
      shift
      wsConfig="$1"
      ;;
    --)
      wsName="$2"
      if [ -n "$wsName" ]; then
        shift 2
      fi
      break
      ;;
  esac
  shift
done

if [ -z "$wsName" ]; then
  echo "ERROR: No webservice name given." >&2
  printUsage
  exit 1
fi

result="$(nix-build --no-out-link --arg wsConfig "$wsConfig" \
  run-webservice.nix -A "$wsName" "${nixBuildOptions[@]}")"

popd > /dev/null
exec "$result" "$@"
