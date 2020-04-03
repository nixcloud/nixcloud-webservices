require ["vnd.dovecot.pipe", "copy", "imapsieve", "environment", "variables"];

if environment :matches "imap.user" "*" {
  set "username" "${1}";
}

if environment :matches "imap.email" "*" {
  set "email" "${1}";
}

pipe :copy "learn-spam.sh" [ "${username}", "${email}" ];
