{
  name = "ip-to-unix";

  machine = { pkgs, lib, nclib, ... }: let
    mkTestWebserver = value: pkgs.writeScript "test-webserver" ''
      #!${pkgs.python3.interpreter}
      from http.server import BaseHTTPRequestHandler, HTTPServer

      class TestHandler(BaseHTTPRequestHandler):
        def do_GET(self):
          self.send_response(200)
          self.send_header('Content-type', 'text/plain')
          self.send_header('Content-length', 7)
          self.end_headers()
          self.wfile.write('${value}\n'.encode('utf-8'))

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
      serviceConfig.ExecStart = nclib.ip2unix {
        program = mkTestWebserver "barfoo";
        rules = lib.singleton {
          direction = "incoming";
          socketActivation = true;
          fdName = "http";
          port = 80;
        };
      };
    };

    systemd.services.test-webserver-direct = {
      description = "Test Webserver Without Socket Activation";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart = nclib.ip2unix {
        program = mkTestWebserver "foobar";
        rules = [
          { socketPath = "/run/test-webserver-direct.socket";
            fdName = "http";
            port = 80;
          }
        ];
      };
    };

    environment.systemPackages = lib.singleton (nclib.ip2unix {
      program = "${pkgs.curl}/bin/curl";
      useBinDir = true;
      baseName = "sockurl";
      rules = [
        { direction = "outgoing";
          address = "1.2.3.4";
          socketPath = "/run/test-webserver-direct.socket";
        }
        { direction = "outgoing";
          address = "4.3.2.1";
          socketPath = "/run/test-webserver-activation.socket";
        }
      ];
    });
  };

  testScript = ''
    $machine->waitForUnit('test-webserver-direct.service');
    $machine->waitForFile('/run/test-webserver-direct.socket');
    $machine->succeed('test "$(sockurl -vvv http://1.2.3.4/)" = foobar');
    $machine->succeed('test "$(sockurl -vvv http://4.3.2.1/)" = barfoo');
  '';
}
