{
  name = "directories";

#  machine.nixcloud.directories = {
#    "////foo/./../bar/".owner = "alice";
#
#    "./foo/./../bar/subdir" = {
#      owner = "root";
#      group = "vip";
#      groups.bobs.write = true;
#    };
#
#    "common/ancestor1".owner = "alice";
#    "common/ancestor1".group = "bobs";
#
#    "common/ancestor2".owner = "bob";
#    "common/ancestor2".group = "vip";
#
#    "super/n/e/s/t/e/d" = {
#      permissions.defaultDirectoryMode = "0700";
#      owner = "alice";
#      group = "vip";
#      postCreate = "id -nu > owner.txt";
#      postCreateAsRoot = "id -nu > root.txt";
#    };
#
#    "little/house/of/bob" = {
#      owner = "bob";
#      group = "vip";
#      users.alice = {};
#      postUpdate = "id -nu > owner.txt";
#      postUpdateAsRoot = "id -nu > root.txt";
#    };
#
#    "/only/alice" = {
#      owner = "alice";
#      group = "bobs";
#      permissions.group.noAccess = true;
#      permissions.others.noAccess = true;
#      permissions.enableACLs = false;
#    };
#  };

  machine.nixcloud.webservices.custom.foo = {
    enable = true;

    proxyOptions = {
      domain ="foo.de";
      port = 8888;
    };

    directories."/relative/to/statedir" = {
      owner = "alice";
      group = "bobs";
    };

    runtimeDirectories."relative/to/runtimedir" = {
      owner = "bob";
      group = "vip";
    };

    directories.overlap.owner = "root";
    runtimeDirectories.overlap.owner = "alice";
  };

  machine.users.groups.vip = {};
  machine.users.groups.bobs = {};
  machine.users.users.alice.isNormalUser = true;
  machine.users.users.bob.isNormalUser = true;
  machine.users.users.bob.extraGroups = [ "bobs" ];

  testScript = { nodes, ... }: let
    inherit (nodes.machine.config.nixcloud.webservices.custom) foo;
  in ''
    import subprocess

    def ensure_stat(path, expect, desc, flag):
        result = subprocess.check_output(['stat', '-c', '%' + flag, path], universal_newlines=True).strip()
        if result != expect:
            raise ValueError(f"{desc} for path {path} is {result} but expected {expect}")

    def ensureOwner(path, owner):
        ensure_stat(path, owner, "owner", "U")

    def ensureGroup(path, group):
        ensure_stat(path, group, "group", "G")

    def ensureMode (directory, user):
        print("ensureMode")
        #ensureStat $_[0], $_[1], 'mode', '04a';

    def showPerms (directory):
        print("showPerms")
        #machine.execute('ls -lad '.$_[0].' >&2; getfacl '.$_[0].' >&2');

    def checkGenericPermissions():
        print("ensureStat")
        showPerms("/foo/bar")
        showPerms("/foo/bar/subdir")
        showPerms("/little/house/of/bob")
        showPerms("/super/n/e/s/t/e/d")
        showPerms("/only/alice")

        ensureOwner("/foo/bar", "alice")
        ensureOwner("/foo/bar/subdir", "root")

        ensureGroup("/foo/bar", "root")
        ensureGroup("/foo/bar/subdir", "vip")

        ensureOwner("/little/house/of/bob", "bob")
        ensureGroup("/little/house/of/bob", "vip")

        ensureOwner("/super/n/e/s/t/e/d", "alice")
        ensureGroup("/super/n/e/s/t/e/d", "vip")

        ensureOwner("/common/ancestor1", "alice")
        ensureGroup("/common/ancestor1", "bobs")

        ensureOwner("/common/ancestor2", "bob")
        ensureGroup("/common/ancestor2", "vip")

        ensureOwner("/only/alice", "alice")
        ensureGroup("/only/alice", "bobs")
        ensureMode("/only/alice", "0700")

        ensureOwner("${foo.stateDir}/relative/to/statedir", "alice")
        ensureGroup("${foo.stateDir}/relative/to/statedir", "bobs")

        ensureOwner("${foo.runtimeDir}/relative/to/runtimedir", "bob")
        ensureGroup("${foo.runtimeDir}/relative/to/runtimedir", "vip")

        ensureOwner("${foo.stateDir}/overlap", "root")
        ensureOwner("${foo.runtimeDir}/overlap", "alice")

    machine.wait_for_unit("multi-user.target")

    print("hi")


    checkGenericPermissions()
'';
#
#    $machine->nest('check if alice can write to a file created by root', sub {
#      $machine->succeed('echo root > /foo/bar/writable_by_alice');
#
#      showPerms "/foo/bar/writable_by_alice";
#
#      $machine->succeed(
#        'su -c "echo alice >> /foo/bar/writable_by_alice" alice',
#        'test "$(tr -d \'\\n\' < /foo/bar/writable_by_alice)" = rootalice'
#      );
#    });
#
#    $machine->nest("check if alice can write to bob's path", sub {
#      $machine->succeed(
#        'su -c "echo hello > /little/house/of/bob/alice.txt" alice'
#      );
#    });
#
#    $machine->nest('check if bob can write to /foo/bar/subdir', sub {
#      $machine->succeed('su -c "echo test > /foo/bar/subdir/bob.txt" bob');
#    });
#
#    $machine->nest('check default directory mode', sub {
#      ensureMode "/super", "0700";
#      ensureMode "/super/n", "0700";
#      ensureMode "/super/n/e", "0700";
#      ensureMode "/super/n/e/s", "0700";
#      ensureMode "/super/n/e/s/t", "0700";
#      ensureMode "/super/n/e/s/t/e", "0700";
#    });
#
#    $machine->nest('check whether postCreate has worked', sub {
#      ensureOwner "/super/n/e/s/t/e/d/owner.txt", "alice";
#      ensureGroup "/super/n/e/s/t/e/d/owner.txt", "vip";
#      ensureOwner "/super/n/e/s/t/e/d/root.txt", "root";
#      ensureGroup "/super/n/e/s/t/e/d/root.txt", "root";
#      $machine->succeed('test "$(< /super/n/e/s/t/e/d/owner.txt)" = alice');
#      $machine->succeed('test "$(< /super/n/e/s/t/e/d/root.txt)" = root');
#    });
#
#    $machine->nest('check whether postUpdate has worked', sub {
#      ensureOwner "/little/house/of/bob/owner.txt", "bob";
#      ensureGroup "/little/house/of/bob/owner.txt", "vip";
#      ensureOwner "/little/house/of/bob/root.txt", "root";
#      ensureGroup "/little/house/of/bob/root.txt", "root";
#      $machine->succeed('test "$(< /little/house/of/bob/owner.txt)" = bob');
#      $machine->succeed('test "$(< /little/house/of/bob/root.txt)" = root');
#    });
#
#    $machine->nest('remove postCreate files to check after reboot', sub {
#      $machine->succeed('rm /super/n/e/s/t/e/d/owner.txt');
#      $machine->succeed('rm /super/n/e/s/t/e/d/root.txt');
#    });
#
#    $machine->nest('remove postUpdate files to check after reboot', sub {
#      $machine->succeed('rm /little/house/of/bob/owner.txt');
#      $machine->succeed('rm /little/house/of/bob/root.txt');
#    });
#
#    $machine->nest('rebooting machine', sub {
#      $machine->shutdown;
#      $machine->waitForUnit('multi-user.target');
#    });
#
#    checkGenericPermissions;
#
#    $machine->nest('check whether the file owner has been fixed up', sub {
#      showPerms "/foo/bar/writable_by_alice";
#      ensureOwner "/foo/bar/writable_by_alice", "alice";
#      ensureGroup "/foo/bar/writable_by_alice", "root";
#    });
#
#    $machine->nest('check whether postCreate ran on existing directory', sub {
#      $machine->fail('test -e /super/n/e/s/t/e/d/owner.txt');
#      $machine->fail('test -e /super/n/e/s/t/e/d/root.txt');
#    });
#
#    $machine->nest('check whether postUpdate ran on existing directory', sub {
#      $machine->succeed('test -e /little/house/of/bob/owner.txt');
#      $machine->succeed('test -e /little/house/of/bob/root.txt');
#    });
#
#    $machine->nest('check whether noAccess modes are applied correctly', sub {
#      ensureOwner "/only/alice", "alice";
#      ensureGroup "/only/alice", "bobs";
#      ensureMode "/only/alice", "0700";
#    });
#  '';
}
