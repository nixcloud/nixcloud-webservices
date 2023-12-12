# Replacement from master branch 24. Nov. 2018
# This includes:
#   https://github.com/NixOS/nixpkgs/pull/51012
#   https://github.com/NixOS/nixpkgs/pull/49809
#   https://github.com/NixOS/nixpkgs/pull/49792
#   https://github.com/NixOS/nixpkgs/pull/49620
# Can be removed after 19.03 release
#{pkgs, ...}:
#let
#  nixpkgs = builtins.fetchTarball {
#    url = https://github.com/NixOS/nixpkgs/archive/0d753af6617bb74535af0601a2cdce1a8c647889.tar.gz;
#    sha256 = "1jsvf4akcwifjmgyhnc5s7zl7wss93vpm23z5yxyzy7vnh9x429c";
#  };
#in {
#  disabledModules = [
    #"services/mail/rspamd.nix"
    #"services/mail/rspamd.nix:anon-1"
    #"services/mail/rspamd.nix:anon-2"
    #"services/mail/rspamd.nix:anon-3"
#  ];
#  imports = [
    #"${nixpkgs}/nixos/modules/services/mail/rspamd.nix"
#  ];
#}
{}