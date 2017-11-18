{ options, lib, wsName, ... }:

{
  options.meta = {
    license = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true;
      description = let
        url = "https://github.com/NixOS/nixpkgs/blob/master/lib/licenses.nix";
      in ''
        A license attribute from the list found in <link
        xlink:href="${url}"><filename>lib/licenses.nix</filename> file</link>
        in the upstream nixpkgs source.
      '';
    };
  };

  config.assertions = lib.singleton {
    assertion = options.meta.license.isDefined;
    message = "No 'meta.license' defined for web service '${wsName}'.";
  };
}
