{
  name = "version";

  machine = {};

  testScript = ''
    $machine->waitForUnit('multi-user.target');
    $machine->succeed(
      'nixcloud-version | grep -q \'^\(master\|[0-9a-f]\{40\}\)$\''',
      'nixos-version | grep -q nixcloud'
    );
  '';
}
