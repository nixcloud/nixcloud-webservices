{
  name = "leaps";

  machine.nixcloud.reverse-proxy.enable = true;
  machine.nixcloud.reverse-proxy.extendEtcHosts = true;
  machine.nixcloud.webservices.leaps = {
    foo.enable = true;
    foo.proxyOptions.TLS = "none";
    foo.proxyOptions.domain = "example.com";
    foo.proxyOptions.http.mode = "on";
    foo.proxyOptions.https.mode = "off";
    foo.proxyOptions.port = 8080;

    bar.enable = true;
    bar.proxyOptions.TLS = "none";
    bar.proxyOptions.domain = "example.org";
    bar.proxyOptions.http.mode = "on";
    bar.proxyOptions.https.mode = "off";
    bar.proxyOptions.port = 8081;
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
    $machine->succeed('curl http://example.com/ | grep -qF leaps_logo.png');
    $machine->succeed('curl http://example.org/ | grep -qF leaps_logo.png');

    ensureOwner "/var/lib/nixcloud/webservices/leaps-foo", "leaps-foo";
    ensureGroup "/var/lib/nixcloud/webservices/leaps-foo", "leaps-foo";

    ensureOwner "/var/lib/nixcloud/webservices/leaps-bar", "leaps-bar";
    ensureGroup "/var/lib/nixcloud/webservices/leaps-bar", "leaps-bar";
  '';
}
