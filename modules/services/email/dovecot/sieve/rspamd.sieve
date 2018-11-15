require ["vnd.dovecot.filter", "envelope", "variables"];

if envelope :matches "to" "*" {
  set "destination" "${1}";
}

filter "rspamd.sh" [ "${destination}" ];
