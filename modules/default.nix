{
  # https://github.com/NixOS/nixpkgs/pull/29365
  disabledModules = [ "services/mail/opendkim.nix" ];

  imports = [
    core/packages.nix
    core/hashed-modules.nix
    core/testing.nix
    services/reverse-proxy
    services/email/opendkim.nix
    services/email/nixcloud-email.nix
    ./web
  ];
}
