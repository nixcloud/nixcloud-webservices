{
  name = "taigaio";

  machine.nixcloud.reverse-proxy.enable = true;
  machine.nixcloud.reverse-proxy.extendEtcHosts = true;
  machine.nixcloud.webservices.taigaio = {
    foo.enable = true;
    foo.proxyOptions.TLS = "none";
    foo.proxyOptions.domain = "example.com";
    foo.proxyOptions.http.mode = "on";
    foo.proxyOptions.https.mode = "off";
    foo.proxyOptions.port = 8080;
  };

  testScript = ''
    # XXX: This is copied from tests/directories.nix, make it DRY!
    sub ensureStat ($$$$) {
      my ($path, $expect, $desc, $flag) = @_;
      my $result = $machine->succeed('stat -c %'.$flag.' '.$path);
      chomp $result;
      die "$desc for path $path is $result but expected $expect"
        unless $result eq $expect;
    }

    sub ensureOwner ($$) {
      ensureStat $_[0], $_[1], 'owner', 'U';
    }

    sub ensureGroup ($$) {
      ensureStat $_[0], $_[1], 'group', 'G';
    }

    $machine->waitForUnit('multi-user.target');
    $machine->waitForOpenPort(80);
    $machine->waitForOpenPort(8080);
    $machine->succeed('curl http://example.com/ | grep -qF leaps_logo.png');

    ensureOwner "/var/lib/nixcloud/webservices/leaps-foo/www", "leaps-foo";
    ensureGroup "/var/lib/nixcloud/webservices/leaps-foo/www", "leaps-foo";

    ensureOwner "/var/lib/nixcloud/webservices/leaps-bar/www", "leaps-bar";
    ensureGroup "/var/lib/nixcloud/webservices/leaps-bar/www", "leaps-bar";
  '';
}
