{ pkgs, ... }:

let
  #servicescript that creates a file
  makeScript = scriptName: pkgs.writeText "serviceScript" ''
    #!${pkgs.bash}/bin/bash
    while true; do touch /${scriptName}; sleep 1; done
  '';
  #derviation for aboves script
  makeScriptDerivation = script: (pkgs.stdenv.mkDerivation {
    name = "testscript";
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp ${script} $out/bin/yesscript
      chmod u+x $out/bin/*
    '';
  });
  #container configuration with that script
  makeConfig = scriptName: pkgs.writeText "testScript" ''{
    autostart = true;
    configuration = {
      networking.firewall.allowPing = true;
      systemd.services.bar = {
        description = "YesItWorks ${scriptName} Daemon";

          wantedBy = [ "multi-user.target" ];
          after = [ "network.target" ];
          serviceConfig = {
            ExecStart = "${makeScriptDerivation (makeScript scriptName)}/bin/yesscript";
            Restart = "always";
            Type="simple";
          };
        };
      };

    } '';

  containerConfig = makeConfig "yesitworks";
  containerConfigRollback = makeConfig "yesitrollsback";
  containerConfigUpdate = makeConfig "yesitupdates";

  #empty container
  containerTestTwo = pkgs.writeText "test2" ''
  {
    configuration = {  };
  }'';

  #container with fixed ip
  containerTestThree = pkgs.writeText "test3" ''
  {
    network = {
      ip = "10.10.10.10";
    };
    configuration = {  };
  }'';

  containerTest4 = pkgs.writeText "test4" ''
  {
    configuration = {  };
  }'';

  containerPreBuild = [
    (import ./bin/helper/lxc-container.nix {
      name="test";
      ip="10.101.0.2";
      container = import containerConfig;
    })
    (import ./bin/helper/lxc-container.nix {
      name="empty";
      ip="10.101.0.2";
      container = import containerTestTwo;
    })
  ];

in {
  name = "nixcloud-container";

  machine = { pkgs, lib, ... }: {
    nix.nixPath = [ "nixpkgs=${pkgs.path}" ];
    nix.binaryCaches = lib.mkForce [];
    nixcloud.container.enable = true;
    networking.firewall.enable = false;

    virtualisation.memorySize = 2048;
    # Needed so that we have all dependencies available for building the
    # container config within the VM.
    virtualisation.pathsInNixDB = [ pkgs.stdenv ] ++ containerPreBuild;
  };

  testScript = ''
    $machine->waitForUnit('multi-user.target');

    $machine->nest('list all containers, should be empty', sub {
      $machine->succeed('
        if [[ $(nixcloud-container list) ]]; then
          echo "Output should be empty."
          exit 1
        else
          exit 0
        fi
      ');
    });

    $machine->succeed('
      #make sure the profile directory exists
      mkdir -p /nix/var/nix/profiles
    ');

    $machine->succeed('
      #create a new container
      nixcloud-container create test ${containerConfig} >&2
    ');

    $machine->nest('list all containers, should not be empty', sub {
      $machine->succeed('
        if [[ $(nixcloud-container list) ]]; then
          exit 0
        else
          echo "Output should not be empty."
          exit 1
        fi
      ');
    });

    $machine->nest('create a container that already exists', sub {
      $machine->fail('nixcloud-container create test ${containerConfig} >&2');
    });

    $machine->nest('start the container', sub {
      $machine->succeed('nixcloud-container start test >&2');
      $machine->waitUntilSucceeds('test -f /var/lib/lxc/test/rootfs/yesitworks');
    });

    $machine->nest('ping the container', sub{
      #ping the container
      $machine->succeed('ping -c 1 10.101.0.2');
      #ping the host
      $machine->succeed('lxc-attach -n test -- ping -c 1 10.101.0.1');
    });

    $machine->nest('test if login into the container works', sub{
      #create a file in the container rootFS
      $machine->succeed('touch /var/lib/lxc/test/rootfs/logintest');
      #login to the container and check if the file exists
      $machine->succeed('lxc-attach -n test -- test -f /logintest');
    });

    $machine->nest('try to start container while it is still running', sub {
      $machine->succeed('
        if [[ $(nixcloud-container start test) != "*Container is already running.*" ]]; then
          exit 0
        else
          echo "Container should already be running."
          exit 1
        fi
      ');
    });

    $machine->nest('check if container runs with non-root privileges', sub {
      $machine->succeed('ps aux | grep "100000.*systemd"');
    });

    $machine->nest('terminate a machine that does not exist', sub {
      $machine->fail('nixcloud-container terminate testbar');
    });

    $machine->nest('terminate a machine that does exist', sub {
      $machine->succeed('nixcloud-container terminate test');
    });

    $machine->nest('update the existing container', sub {
      $machine->succeed(
        'nixcloud-container update test ${containerConfigRollback}'
      );
      $machine->succeed(
        'nixcloud-container update test ${containerConfigUpdate}'
      );
    });

    $machine->nest('restart the container', sub {
      $machine->succeed('nixcloud-container start test');
      $machine->waitUntilSucceeds('test -f /var/lib/lxc/test/rootfs/yesitupdates');
    });

    $machine->nest('switch to previous profile', sub{
      #TODO FIXME currently when switching the profile inside a running container_
      # the nixos script returns with exit 2 even if the configuration was
      # successfully switched because it does not manage to remount some directorys
      # once this bug is fixed this test should be changed back to 'succeed'
      $machine->fail('nixcloud-container rollback test >&2');
      $machine->waitUntilSucceeds('test -f /var/lib/lxc/test/rootfs/yesitrollsback');
      $machine->succeed('nixcloud-container list-generations test >&2');
    });

    $machine->succeed('
      if [[ $(nixcloud-container show-ip test) == "10.101.0.2" ]]; then
        exit 0
      else
        echo "Container should have a valid ip."
        exit 1
      fi
    ');

    $machine->succeed('nixcloud-container list >&2');
    $machine->nest('list all containers, should not be empty', sub {
      $machine->succeed('
        if [[ $(nixcloud-container list) ]]; then
          exit 0
        else
          echo "Output should not be empty."
          exit 1
        fi
      ');
    });

    $machine->succeed('rm /var/lib/lxc/test/rootfs/yesitrollsback');


    #restart the lxc-autostart service this must restart the test container
    $machine->nest('testing autostart of the container', sub{
      $machine->succeed('systemctl restart lxc-autostart.service');
      $machine->waitUntilSucceeds('
        nixcloud-container state test | grep "RUNNING"
      ');
      $machine->waitUntilSucceeds('test -f /var/lib/lxc/test/rootfs/yesitrollsback');
    });

    $machine->nest('terminate a machine that does exist', sub {
      $machine->succeed('nixcloud-container terminate test');
    });

    $machine->nest('delete a machine that does exist', sub {
      $machine->succeed('nixcloud-container destroy test');
    });

    $machine->nest('list all containers, should be empty', sub {
      $machine->succeed('
        if [[ $(nixcloud-container list) ]]; then
          echo "Output should be empty."
          exit 1
        else
          exit 0
        fi
      ');
    });

    #test if ip is freed
    $machine->succeed('nixcloud-container create empty ${containerTestTwo} >&2');
    $machine->succeed('
      if [[ $(nixcloud-container show-ip empty) == "10.101.0.2" ]]; then
        exit 0
      else
        echo "Container should have the ip 10.101.0.2."
        exit 1
      fi
    ');
    #test fixed ip
    $machine->succeed('nixcloud-container create fixed ${containerTestThree} >&2');
    $machine->succeed('
      if [[ $(nixcloud-container show-ip fixed) == "\"10.10.10.10\"" ]]; then
        exit 0
      else
        echo "Container should have the ip 10.10.10.10."
        exit 1
      fi
    ');
    #test fixed ip
    $machine->succeed('nixcloud-container create test4 ${containerTest4} >&2');
    $machine->succeed('
      if [[ $(nixcloud-container show-ip test4) == "10.101.0.3" ]]; then
        exit 0
      else
        echo "Container should have the ip 10.101.0.3."
        exit 1
      fi
    ');



  '';
}
