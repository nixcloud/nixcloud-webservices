{
  name = "version";

  machine = {};

  testScript = ''
    $machine->waitForUnit('multi-user.target');
    $machine->succeed('nixcloud-version | grep -q "^[0-9a-f]\\{40\\}$"');
    $machine->succeed('nixos-version | grep -q nixcloud');
  '';
}
