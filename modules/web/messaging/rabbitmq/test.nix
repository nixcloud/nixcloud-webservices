let
  rabbitMQWebService = { config, pkgs, ... }: let
    # FIXME: Use python3Packages here as soon as pika 0.13.0 hits the nixos-
    #        unstable channel, because it fixes support with Python 3.7.
    inherit (pkgs.python36Packages) buildPythonApplication pika;
    inherit (config.tools) useRabbitMQ;
    mkPyTest = name: src: buildPythonApplication {
      name = "test-rabbitmq-${name}";
      propagatedBuildInputs = [ pika ];
      postPatch = ''
        cat > setup.py <<SETUP
        from distutils.core import setup
        setup(name='test-rabbitmq-${name}', scripts=['test-rabbitmq-${name}'])
        SETUP
      '';
      src = pkgs.writeTextDir "test-rabbitmq-${name}" ''
        #!/usr/bin/env python
        ${src}
      '';
    };
  in {
    config.messaging.rabbitmq.enable = true;

    config.systemd.services.test-send = {
      description = "Test Sending to RabbitMQ";
      serviceConfig.Type = "oneshot";
      serviceConfig.ExecStart = "${useRabbitMQ} ${mkPyTest "send" ''
        import pika

        cparams = pika.ConnectionParameters(host='localhost')
        connection = pika.BlockingConnection(cparams)
        channel = connection.channel()

        channel.queue_declare(queue='hello')

        channel.basic_publish(exchange="", routing_key='hello', body='world')
        connection.close()
      ''}/bin/test-rabbitmq-send";
    };

    config.systemd.services.test-recv = {
      description = "Test Receiving from RabbitMQ";
      serviceConfig.Type = "oneshot";
      serviceConfig.RemainAfterExit = true;
      serviceConfig.ExecStart = "${useRabbitMQ} ${mkPyTest "recv" ''
        import sys
        import pika

        cparams = pika.ConnectionParameters(host='localhost')
        connection = pika.BlockingConnection(cparams)
        channel = connection.channel()

        channel.queue_declare(queue='hello')

        def callback(ch, method, properties, body):
            open('/tmp/received', 'wb').write(body)
            raise SystemExit

        channel.basic_consume(callback, queue='hello', no_ack=True)

        open('/tmp/recv-ready', 'w')
        channel.start_consuming()
      ''}/bin/test-rabbitmq-recv";
    };

    meta.license = null;
  };

in {
  name = "rabbitmq";

  machine = { lib, nclib, pkgs, ... }: {
    imports = let
      mkWebService = import ../../../../lib/make-webservice.nix;
    in lib.singleton (mkWebService "rabbitmq-test" rabbitMQWebService);

    nixcloud.webservices.rabbitmq-test.foo.enable = true;
  };

  testScript = ''
    machine.wait_for_unit("rabbitmq-test-foo-rabbitmq.service")

    with subtest("check whether stop/start works"):
      machine.succeed(
        "systemctl stop rabbitmq-test-foo-rabbitmq.service",
        "systemctl start rabbitmq-test-foo-rabbitmq.service"
      )
      machine.wait_for_unit("rabbitmq-test-foo-rabbitmq.service")

    with subtest("sending and receiving message"):
      machine.succeed(
        "systemctl start --no-block rabbitmq-test-foo-test-recv >&2",
        "while [ ! -e /tmp/recv-ready ]; do sleep 0.1; done",
        "rabbitmq-test-foo-rabbitmqctl list_queues | grep -q hello",
        "systemctl start rabbitmq-test-foo-test-send >&2"
      )

      machine.wait_for_unit("rabbitmq-test-foo-test-recv.service")
      machine.succeed("test '$(< /tmp/received)' = world")
    };

    with subtest("make sure EPMD is not listening"):
      machine.fail("nc -z 127.0.0.1 4369")
  '';
}
