require ["fileinto", "reject", "envelope", "mailbox", "reject"];

# spamassassin
if header :contains "X-Spam-Flag" "YES" {
  fileinto :create "Spam";
  stop;
}
# rspamd
if header :contains "X-Spam" "YES" {
  fileinto :create "Spam";
  stop;
}
