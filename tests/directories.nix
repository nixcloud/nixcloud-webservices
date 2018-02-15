{
  name = "directories";

  machine.nixcloud.directories = {
    "////foo/./../bar/".owner = "alice";

    "./foo/./../bar/subdir" = {
      owner = "root";
      group = "vip";
      groups.bobs.write = true;
    };

    "common/ancestor1".owner = "alice";
    "common/ancestor1".group = "bobs";

    "common/ancestor2".owner = "bob";
    "common/ancestor2".group = "vip";

    "super/n/e/s/t/e/d" = {
      permissions.defaultDirectoryMode = "0700";
      owner = "alice";
      group = "vip";
    };

    "little/house/of/bob" = {
      owner = "bob";
      group = "vip";
      users.alice = {};
    };
  };

  machine.users.groups.vip = {};
  machine.users.groups.bobs = {};
  machine.users.users.alice.isNormalUser = true;
  machine.users.users.bob.isNormalUser = true;
  machine.users.users.bob.extraGroups = [ "bobs" ];

  testScript = ''
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

    sub ensureMode ($$) {
      ensureStat $_[0], $_[1], 'mode', '04a';
    }

    sub showPerms ($) {
      $machine->execute('ls -lad '.$_[0].' >&2; getfacl '.$_[0].' >&2');
    }

    sub checkGenericPermissions {
      showPerms "/foo/bar";
      showPerms "/foo/bar/subdir";
      showPerms "/little/house/of/bob";
      showPerms "/super/n/e/s/t/e/d";

      ensureOwner "/foo/bar", "alice";
      ensureOwner "/foo/bar/subdir", "root";

      ensureGroup "/foo/bar", "root";
      ensureGroup "/foo/bar/subdir", "vip";

      ensureOwner "/little/house/of/bob", "bob";
      ensureGroup "/little/house/of/bob", "vip";

      ensureOwner "/super/n/e/s/t/e/d", "alice";
      ensureGroup "/super/n/e/s/t/e/d", "vip";

      ensureOwner "/common/ancestor1", "alice";
      ensureGroup "/common/ancestor1", "bobs";

      ensureOwner "/common/ancestor2", "bob";
      ensureGroup "/common/ancestor2", "vip";
    }

    $machine->waitForUnit('multi-user.target');

    checkGenericPermissions;

    $machine->nest('check if alice can write to a file created by root', sub {
      $machine->succeed('echo root > /foo/bar/writable_by_alice');

      showPerms "/foo/bar/writable_by_alice";

      $machine->succeed(
        'su -c "echo alice >> /foo/bar/writable_by_alice" alice',
        'test "$(tr -d \'\\n\' < /foo/bar/writable_by_alice)" = rootalice'
      );
    });

    $machine->nest("check if alice can write to bob's path", sub {
      $machine->succeed(
        'su -c "echo hello > /little/house/of/bob/alice.txt" alice'
      );
    });

    $machine->nest('check if bob can write to /foo/bar/subdir', sub {
      $machine->succeed('su -c "echo test > /foo/bar/subdir/bob.txt" bob');
    });

    $machine->nest('check default directory mode', sub {
      ensureMode "/super", "0700";
      ensureMode "/super/n", "0700";
      ensureMode "/super/n/e", "0700";
      ensureMode "/super/n/e/s", "0700";
      ensureMode "/super/n/e/s/t", "0700";
      ensureMode "/super/n/e/s/t/e", "0700";
    });

    $machine->nest('rebooting machine', sub {
      $machine->shutdown;
      $machine->waitForUnit('multi-user.target');
    });

    checkGenericPermissions;

    $machine->nest('check whether the file owner has been fixed up', sub {
      showPerms "/foo/bar/writable_by_alice";
      ensureOwner "/foo/bar/writable_by_alice", "alice";
      ensureGroup "/foo/bar/writable_by_alice", "root";
    });
  '';
}
