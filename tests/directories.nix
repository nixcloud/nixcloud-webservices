{
  name = "directories";

  machine.nixcloud.directories = {
    "////foo/./../bar/".owner = "alice";

    "./foo/./../bar/subdir" = {
      owner = "root";
      group = "vip";
    };

    "super/n/e/s/t/e/d" = {
      permissions.defaultDirectoryMode = "0700";
      owner = "alice";
      group = "vip";
    };
  };

  machine.users.groups.vip = {};
  machine.users.users.alice.isNormalUser = true;

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

      ensureOwner "/foo/bar", "alice";
      ensureOwner "/foo/bar/subdir", "root";

      ensureGroup "/foo/bar", "root";
      ensureGroup "/foo/bar/subdir", "vip";

      ensureOwner "/super/n/e/s/t/e/d", "alice";
      ensureGroup "/super/n/e/s/t/e/d", "vip";
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
