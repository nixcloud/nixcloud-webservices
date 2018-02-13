{
  name = "directories";

  machine.nixcloud.directories = {
    "////foo/./../bar/".owner = "alice";
    "./foo/./../bar/subdir".owner = "root";
    "./foo/./../bar/subdir".group = "vip";
  };

  machine.users.groups.vip = {};
  machine.users.users.alice.isNormalUser = true;

  testScript = ''
    sub ensureOwnerGroup ($$$$) {
      my ($path, $expect, $desc, $flag) = @_;
      my $result = $machine->succeed('stat -c %'.$flag.' '.$path);
      chomp $result;
      die "$desc for path $path is $result but expected $expect"
        unless $result eq $expect;
    }

    sub ensureOwner ($$) {
      ensureOwnerGroup $_[0], $_[1], 'owner', 'U';
    }

    sub ensureGroup ($$) {
      ensureOwnerGroup $_[0], $_[1], 'group', 'G';
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

    $machine->nest('rebooting machine', sub {
      $machine->shutdown;
      $machine->waitForUnit('multi-user.target');
    });

    checkGenericPermissions;

    $machine->nest('check whether the file owner has been fixed up', sub {
      ensureOwner "/foo/bar/writable_by_alice", "alice";
      ensureGroup "/foo/bar/writable_by_alice", "root";
    });
  '';
}
