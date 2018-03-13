{
  disabledModules = [  
  # https://github.com/NixOS/nixpkgs/pull/29365
    "services/mail/opendkim.nix"
  # Needed because services.postfix.relayPort is only available in 18.03
    "services/mail/postfix.nix"
    "services/mail/pfix-srsd.nix"
  ];

  imports = [
    core/dbshell
    core/directories
    core/packages.nix
    core/hashed-modules.nix
    core/testing.nix
    services/reverse-proxy
    services/email/opendkim.nix
    services/email/postfix.nix
    services/email/pfix-srsd.nix
    services/email/nixcloud-email.nix
    ./web
  ];
}
