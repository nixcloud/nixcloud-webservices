export tempDbSocketPath="$TMPDIR/.mysql.sock"
export tempDbPhpHostname="localhost:$tempDbSocketPath"

escapeSqlString() {
  local slashes="${1//\\/\\\\}"
  echo "${slashes//\'/\\\'}"
}

tempdbInit() {
  @eatmydata@ mysql_install_db \
    --basedir="@mysqlBaseDir@" \
    --datadir="$TMPDIR/tempdb" \
    --skip-name-resolve
  @eatmydata@ mysqld \
    --basedir="@mysqlBaseDir@" \
    --datadir="$TMPDIR/tempdb" \
    --skip-networking \
    --socket="$tempDbSocketPath" &

  while [ ! -S "$tempDbSocketPath" ]; do sleep 0.1; done

  local newUser="'$(escapeSqlString "$tempDbUser")'@'localhost'"
  local newDb="\`${tempDbName//\`/\\\`}\`"
  echo "CREATE USER $newUser; GRANT ALL PRIVILEGES ON $newDb.* TO $newUser;" \
    | mysql -uroot --socket="$tempDbSocketPath"
}

tempdbShell() {
  mysql -u "$tempDbUser" --socket="$tempDbSocketPath" "$tempDbName" "$@"
}

tempdbDump() {
  mysqldump -u "$tempDbUser" --socket="$tempDbSocketPath" "$tempDbName" "$@"
}
