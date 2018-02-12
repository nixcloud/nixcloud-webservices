{
  name = "directories";

  machine.nixcloud.directories = {
    "////foo/./../bar/".owner = "nobody";
    "./foo/./../bar/subdir".owner = "root";
  };

  testScript = ''
    sub ensureOwner ($$) {
      my ($path, $user) = @_;
      my $owner = $machine->succeed('stat -c %U '.$path);
      chomp $owner;
      die "owner for path $path is $owner but expected $user"
        unless $owner eq $user;
    }

    $machine->waitForUnit('multi-user.target');
    ensureOwner "/foo/bar", "nobody";
    ensureOwner "/foo/bar/subdir", "root";
  '';
}
