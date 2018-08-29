{
  name = "rabbitmq";

  machine.nixcloud.webservices.custom.foo = {
    enable = true;
    messaging.rabbitmq.enable = true;
  };

  testScript = ''
    $machine->waitForUnit('custom-foo-rabbitmq.service');

    subtest "make sure EPMD is disabled", sub {
      $machine->fail('nc -z 127.0.0.1 4369');
    };

    $machine->execute('netstat -ntlpue >&2');
    $machine->execute('COLUMNS=4000 ps auxf >&2');
  '';
}
