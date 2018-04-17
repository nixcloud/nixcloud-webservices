{ ... } : {
#     nixcloud.TLS.certs = {
#       "example.com" = {
#         domain = "aaaaaaaaahhhhh.bb";
#         #mode = "ACME";
#         extraDomains = [ "linux.org" ];
#         email = "foo@bar.com";
#         restart = [ "dovecot2.service" "foo.service" ];
#         reload = [ "foo.service" ];
#       };
#     };
}
