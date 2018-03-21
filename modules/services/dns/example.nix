{
  de.nixcloud = {
    SOA = {
      mname = "ns.nixcloud.io.";
      rname = "dnsadmin.nixcloud.de.";
    };

    NS = [ "ns1.nixcloud.io." "ns2.nixcloud.io." ];

    MX = [
      { preference = 10; exchange = "spam.nixcloud.de."; }
      { preference = 20; exchange = "mail.nixcloud.io."; }
      { preference = 20; exchange = "mailbackup.nixcloud.io."; }
    ];

    A = "5.6.7.8";
    AAAA = "1234::1";

    CAA = {
      critical = true;
      issue = "letsencrypt.org; policy=ev";
      iodef = [
        "https://sslissues.nixcloud.io" "mailto:sslissues@nixcloud.io"
      ];
    };

    www.A = "1.2.3.4";
    www.AAAA = "dead::1";

    "*".CNAME = "fallback.nixcloud.io.";

    _tcp._xmpp-server.SRV = {
      priority = 10;
      weight = 0;
      port = 5269;
      target = "xmpp.nixcloud.de.";
    };

    _acme-challenge.TXT = "2lOgCI0p_LRhtrJMh1aTYAek6h404nT71-DkdbQcxfA";
  };

  io.nixcloud = {
    SOA = {
      mname = "ns.nixcloud.io.";
      rname = "superadmin.nixcloud.io.";
    };

    NS = [ "ns1.nixcloud.io." "ns2.nixcloud.io." ];

    CAA.issue = [ "letsencrypt.org" "ca.example.org" ];

    MX.preference = 10;
    MX.exchange = "mail";

    ns.CNAME = "ns1.nixcloud.io.";

    ns1.A = "7.2.9.1";
    ns1.AAAA = "7291::1";

    ns2.A = "9.2.4.7";
    ns2.AAAA = "9247::2";

    mail.A = "7.4.1.9";
    mail.AAAA = "abcd::201";

    fallback.A = "2.3.7.4";
    fallback.AAAA = "2374::1";

    SSHFP = {
      algorithm = "ed25519";
      hashType = "sha256";
      fingerprint = "8Ohy8G7tDQmm4AponxBklkT+BCBnDFkBNFySkxuKz0w";
    };
  };
}
