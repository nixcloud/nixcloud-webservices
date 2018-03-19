{
  de.nixcloud = {
    SOA = {
      mname = "ns.nixcloud.io.";
      rname = "dnsadmin.nixcloud.de.";
    };

    NS = [ "ns1.nixcloud.io." "ns2.nixcloud.io." ];

    MX."10" = [ "spam.nixcloud.de." ];
    MX."20" = [ "mail.nixcloud.io." "mailbackup.nixcloud.io." ];

    A = "5.6.7.8";
    AAAA = "1234::1";

    CAA = {
      critical = true;
      issue.domain = "letsencrypt.org";
      issue.tags.policy = "ev";
      iodef = [
        "https://sslissues.nixcloud.io" "mailto:sslissues@nixcloud.io"
      ];
    };

    www.A = "1.2.3.4";
    www.AAAA = "dead::1";

    "*".CNAME = "fallback.nixcloud.io.";

    _xmpp-server._tcp.SRV = {
      prio = 10;
      weight = 0;
      port = 5269;
      dest = "xmpp.nixcloud.de.";
    };

    _acme-challenge.TXT = "foobar";
  };

  io.nixcloud = {
    SOA = {
      mname = "ns.nixcloud.io.";
      rname = "superadmin.nixcloud.io.";
    };

    NS = [ "ns1.nixcloud.io." "ns2.nixcloud.io." ];

    CAA.issue.domain = [ "letsencrypt.org" "ca.example.org" ];

    ns.CNAME = "ns1.nixcloud.io.";

    ns1.A = "7.2.9.1";
    ns1.AAAA = "7291::1";

    ns2.A = "9.2.4.7";
    ns2.AAAA = "9247::2";

    fallback.A = "2.3.7.4";
    fallback.AAAA = "2374::1";

    SSHFP = {
      algorithm = "ed25519";
      hashType = "sha256";
      fpr = "foobar";
    };
  };
}
