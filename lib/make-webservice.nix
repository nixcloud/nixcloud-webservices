wsName: module:

{ config, options, pkgs, lib, ... }@toplevel:

{
  options.nixcloud.webservices.${wsName} = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      imports = [
        module
        ../modules/web/core/base.nix
        ../modules/web/backends/apache.nix
        ../modules/web/backends/lighttpd.nix
        ../modules/web/backends/nginx.nix
      ];
      _module.args = { inherit wsName pkgs toplevel; };
    });
    default = {};
    # TODO: Flesh out this description.
    description = "NixCloud ${wsName} web service definitions";
  };
}
