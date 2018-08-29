{
  name = "ip-to-unix";

  machine = { pkgs, lib, nclib, ... }: let
    testWebserver = pkgs.writeScript "test-webserver" ''
      #!${pkgs.python3.interpreter}
      from http.server import BaseHTTPRequestHandler, HTTPServer

      class TestHandler(BaseHTTPRequestHandler):
        def do_GET(self):
          self.send_response(200)
          self.send_header('Content-type', 'text/plain')
          self.send_header('Content-length', 7)
          self.end_headers()
          self.wfile.write('foobar\n'.encode('utf-8'))

      server = HTTPServer(("", 80), TestHandler)
      print(server.server_name)
      print(server.server_port)
      server.serve_forever()
    '';
  in {
    systemd.sockets.test-webserver-socket-activation = {
      description = "Socket For Test Webserver";
      requiredBy = [ "sockets.target" ];
      socketConfig.ListenStream = "/run/test-webserver-activation.socket";
      socketConfig.FileDescriptorName = "http";
    };

    systemd.services.test-webserver-socket-activation = {
      description = "Test Webserver With Socket Activation";
      serviceConfig.ExecStart = nclib.ipToUnix {
        program = testWebserver;
        rules = [
          { socketActivation = true; fdName = "http"; port = 80; }
        ];
      };
    };

    systemd.services.test-webserver-direct = {
      description = "Test Webserver Without Socket Activation";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart = nclib.ipToUnix {
        program = testWebserver;
        rules = [
          { socketPath = "/run/test-webserver-direct.socket";
            fdName = "http";
            port = 80;
          }
        ];
      };
    };

    environment.systemPackages = lib.singleton (nclib.ipToUnix {
      program = "${pkgs.curl}/bin/curl";
      useBinDir = true;
      baseName = "sockurl";
      rules = [
        { direction = "outgoing";
          address = "1.2.3.4";
          socketPath = "/run/test-webserver-direct.socket";
        }
      ];
    });
  };

  testScript = ''
    $machine->waitForUnit('test-webserver-direct.service');
    $machine->waitForFile('/run/test-webserver-direct.socket');
    $machine->execute('strace -f sockurl -vvv http://1.2.3.4/ >&2');
    $machine->sleep(100);

    # $machine->waitForUnit('sockets.target');
    # $machine->succeed('systemctl start test-webserver.service');
    # $machine->execute('strace -f -s 9999 -p $(systemctl show -p MainPID test-webserver.service | cut -d= -f2) &');
    # $machine->execute('curl -vvv --unix-socket /run/test-webserver.socket'.
    #                   ' http://127.0.0.1/ | grep -q foobar');
    # $machine->sleep(60);
  '';
}
