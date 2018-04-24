{
  alice = {
    domain = "example.org";
    server = "mx.example.org";
    plainPasswd = "testpw1";
    password = "{SSHA256}LDxblDvyoK+wWl1sX+TWntbfkvQ+jATEadp0Q1yfqlNLo2SZ";
  };
  bob = {
    domain = "example.net";
    server = "mx.example.org";
    plainPasswd = "testpw2";
    password = "{SHA256}8NSRIfBpISneREB06+Z/4h9io5c9+9zEEe1abG6gFCQ=";
  };
  foo = {
    domain = "example.com";
    server = "mx.example.com";
    plainPasswd = "testpw3";
    password = "{PBKDF2}$1$NbF7gIsr3MBE6Ice$5000$07072413c01782d9eb2e5d"
             + "919f2c402b8e924c2e";
  };
  bar = {
    domain = "example.com";
    server = "mx.example.com";
    plainPasswd = "testpw4";
    password = "{PLAIN}testpw4";
  };
}
