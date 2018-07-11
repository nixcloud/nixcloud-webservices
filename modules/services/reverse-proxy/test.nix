{ pkgs, nixpkgs, ... }:

let

ws-go-server = pkgs.buildGoPackage rec {
  name = "ws-go-server-${version}";
  version = "0.0.1";

  unpackPhase = ''
    mkdir -p src/src/github.com/ws-go-server/ws-go-server/
    cp ${ws-go-server-src} src/src/github.com/ws-go-server/ws-go-server/main.go
    # setting the weird sourceRoot and the src/src... WTH?
    sourceRoot=`pwd`/src
  '';
  goPackagePath = "github.com/ws-go-server/ws-go-server/";
  goDeps = ws-go-deps;
};

ws-go-client = pkgs.buildGoPackage rec {
  name = "ws-go-client-${version}";
  version = "0.0.1";

  unpackPhase = ''
    mkdir -p src/src/github.com/ws-go-client/ws-go-client/
    cp ${ws-go-client-src} src/src/github.com/ws-go-client/ws-go-client/main.go
    # setting the weird sourceRoot and the src/src... WTH?
    sourceRoot=`pwd`/src
  '';
  goPackagePath = "github.com/ws-go-client/ws-go-client/";
  goDeps = ws-go-deps;
};


# thanks to https://github.com/golang-samples/websocket/blob/master/simple/main.go
ws-go-server-src = pkgs.writeText "main.go" ''
  package main

  import (
          "io"
          "fmt"
          "net/http"
          "golang.org/x/net/websocket"
  )

  func echoHandler(ws *websocket.Conn) {
          io.Copy(ws, ws)
  }

  func main() {
          fmt.Println("GO websocket server running...")

          http.Handle("/myapp/ws", websocket.Handler(echoHandler))
          http.Handle("/", http.FileServer(http.Dir(".")))
          err := http.ListenAndServe(":8080", nil)
          if err != nil {
                  panic("ListenAndServe: " + err.Error())
          }
  }
'';

ws-go-client-src = pkgs.writeText "main.go" ''
  package main

  import (
    "fmt"
    "log"

    "golang.org/x/net/websocket"
  )

  var origin = "http://localhost/"
  var url = "ws://example.ws:80/myapp/ws"

  func main() {
    ws, err := websocket.Dial(url, "", origin)
    if err != nil {
      log.Fatal(err)
    }

    message := []byte("hello, world!")
    _, err = ws.Write(message)
    if err != nil {
      log.Fatal(err)
    }
    fmt.Printf("Send: %s\n", message)

    var msg = make([]byte, 512)
    _, err = ws.Read(msg)
    if err != nil {
      log.Fatal(err)
    }
    fmt.Printf("Receive: %s\n", msg)
  }
'';

ws-go-deps = pkgs.writeText "ws-go-server-deps.nix" ''
[{
   goPackagePath =  "golang.org/x/net";
    fetch =  {
      type =  "git";
       url =  "https://go.googlesource.com/net";
       rev =  "07b51741c1d6423d4a6abab1c49940ec09cb1aaf";
       sha256 =  "12lvdj0k2gww4hw5f79qb9yswqpy4i3bgv1likmf3mllgdxfm20w";
    };
  }]
'';

in

{
  name = "reverse-proxy";

  machine = { pkgs, lib, ... }: {
    nix.nixPath = [ "nixpkgs=${nixpkgs}" "nixos-config=/etc/nixos/configuration.nix" ];
    nix.binaryCaches = lib.mkForce [];

    nixcloud.TLS.certs = lib.mkForce {
      "stupid.io".mode = "selfsigned";
      "exclusive.ws1".mode = "selfsigned";
      "exclusive.ws2".mode = "selfsigned";
      "flags.io".mode = "selfsigned";
      "example.com".mode = "selfsigned";
      "example.ws".mode = "selfsigned";
      "flubb.com".mode = "selfsigned";
    };

    nixcloud.reverse-proxy = {
      enable = true;
      extendEtcHosts = true;
      extraMappings = [
        {
         domain = "stupid.io";
         path = "/";
         port = 8383;
         http.mode = "off";
         https.mode = "off";
         websockets = {
           ws = {
             subpath = "/websocket";
             http.mode = "off";
             https.mode = "off";
           };
         };
        }
        {
          domain = "exclusive.ws1";
          path = "/tt";
          port = 8383;
          http.mode = "off";
          https.mode = "off";
          websockets = {
            ws = {
              subpath = "/websocket";
              http.mode = "on";
              https.mode = "on";
            };
          };
        }
        
        {
          domain = "exclusive.ws2";
          #path = "/";
          port = 8484;
          http.mode = "off";
          https.mode = "off";
          websockets = {
            ws = {
              subpath = "/websocket";
              http.mode = "on";
              https.mode = "on";
            };
          };
        }
        {
          domain = "flags.io";
          path = "/";
          port = 60000;
          http.mode = "on";
          http.extraFlags = ''
            add_header Strict-Transport-Security max-age=345678;
          '';
          https.mode = "on";
          https.extraFlags = ''
            add_header Strict-Transport-Security max-age=345678;
          '';         
         websockets = {
           ws = {
             subpath = "/websocket";
             http.mode = "off";
             https.mode = "off";
           };
         };
        }
      ];
    };
    # including additional extraConfigs which are used for LXC based webservices
    imports = [ ./test ];
    
    services.httpd = {
      enable = true;
      listen = [{
        port = 60000;
        ip = "*";
      }];
      adminAddr="example@example.com";
    };

    # Needed so that we have all dependencies available for building the
    # container config within the VM.
    virtualisation.pathsInNixDB = let
      emptyClosure = (import <nixpkgs/nixos/lib/eval-config.nix> {
        modules = lib.singleton { boot.isContainer = true; };
      }).config.system.build.toplevel;
    in [ pkgs.stdenv emptyClosure ];
  };

  testScript = ''
    $machine->waitForUnit('multi-user.target');
    
    # make sure both are answered by apache
    $machine->succeed('curl http://example.com/wiki | grep "<span>Apache" >&2');
    $machine->succeed('curl -k https://example.com/wiki | grep "<span>Apache" >&2');
    
    # make sure for both there is no entry in example.com/blog
    $machine->succeed('curl http://example.com/blog | grep 404 >&2');
    $machine->succeed('curl -k https://example.com/blog | grep 404 >&2');
    
    # make sure http redirects to https and https works for flubb.com
    # BUG: this test also uses the same port and this should bail out on nix evaluation...
    $machine->succeed('curl http://flubb.com/blog | grep -i "301 Moved Permanently" >&2');
    $machine->succeed('curl -k https://flubb.com/blog | grep "<span>Apache" >&2');
    
    # test basicauth
    $machine->succeed('curl http://example.com/basicauth --user "foo:bar1" | grep "<span>Apache" >&2');
    $machine->succeed('curl http://example.com/basicauth | grep "401 Auth" >&2');
    $machine->succeed('curl -k https://example.com/basicauth --user "foo:bar2" | grep "<span>Apache" >&2');
    $machine->succeed('curl -k https://example.com/basicauth | grep "401 Auth" >&2');
    
    # ipv4/ipv6 tests
    $machine->succeed('cat /etc/hosts >&2');

    $machine->succeed('curl -4 http://example.com/wiki | grep "<span>Apache" >&2');
    $machine->succeed('curl -4 -k https://example.com/wiki | grep "<span>Apache" >&2');
    $machine->succeed('curl -6 http://example.com/wiki | grep "<span>Apache" >&2');
    $machine->succeed('curl -6 -k https://example.com/wiki | grep "<span>Apache" >&2');
    
    # test HSTS
    $machine->succeed('curl -k -s -D- http://flags.io | grep Strict >&2');
    $machine->succeed('curl -k -s -D- https://flags.io | grep Strict >&2');
    
    # test websockets
    $machine->succeed('curl http://example.ws/myapp/ws >&2');
    $machine->succeed('${ws-go-server}/bin/ws-go-server & >&2');
    $machine->succeed('sleep 1; ${ws-go-client}/bin/ws-go-client >&2');
  '';
}
