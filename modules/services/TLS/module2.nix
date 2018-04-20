{ ... } : {

# 
#   nixcloud.TLS.certs = {
#     "foo.de" = {
#       domain = "foo.de1";
#       mode = "ACME";
#     };
#     "example.com" = {
#       domain = "aaaaaaaaahhhhh.bb";
#       extraDomains = [ "flux.com" "flux.com" ];
#       mode = "ACME";
#       email = "foo@bar.com";
#       restart = [ "foo.service" "foo.service"];
#       reload =  [ "foo.service" "bar" ];
#     };
#     #"foo.com".mode = {
#     #  ssl_certificate_key = /flux/to/cert.pem;
#     #  ssl_certificate = /flux/to/key.pem;
#     #};
#   };

}
