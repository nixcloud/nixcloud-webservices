{
  name = "version";

 machine = { pkgs, ... }: {
   environment.systemPackages = [ pkgs.mariadb ];
 };

  testScript = ''
    machine.wait_for_unit("multi-user.target")
    machine.succeed("nixcloud-version | grep -q '^\(master\|[0-9a-f]\{40\}\)$'")
    machine.succeed("nixos-version | grep -q nixcloud")
  '';
}
