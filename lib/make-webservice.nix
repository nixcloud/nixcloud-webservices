wsName: module:

{ config, options, pkgs, lib, ... }@toplevel:

{
  options.nixcloud.webservices.${wsName} = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      imports = [
        module
        ../modules/web/core/base.nix
        ../modules/web/webserver/apache.nix
        ../modules/web/webserver/lighttpd.nix
        ../modules/web/webserver/nginx.nix
        ../modules/web/webserver/darkhttpd.nix
      ];
      _module.args = { inherit wsName pkgs toplevel; };
    });
    default = {};
    # TODO: Flesh out this description.
    description = "NixCloud ${wsName} web service definitions";
  };
}
