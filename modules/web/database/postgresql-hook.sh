export PGHOST="$TMPDIR"
export tempDbSocketPath="$PGHOST"
export tempDbPhpHostname="$PGHOST"

escapeSqlString() {
  echo "${1//\'/\'\'}"
}

tempdbInit() {
  initdb -D "$TMPDIR/tempdb" -E UTF8 -N -U "$tempDbUser"
  [ -z "$createTempDb" ] || createdb "$tempDbName"
  pg_ctl start -w -D "$TMPDIR/tempdb" -o \
    "-F --listen_addresses= --unix_socket_directories=$tempDbSocketPath"
}

tempdbShell() {
  psql "$tempDbName" "$tempDbUser" "$@"
}

tempdbDump() {
  pg_dump -U "$tempDbUser" "$tempDbName" "$@"
}
