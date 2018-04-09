{ system ? builtins.currentSystem, nixpkgs ? <nixpkgs> }:

let
  pkgs = import nixpkgs { inherit system; };
  inherit (pkgs) lib;

in {
  tests = let
    mkJob = lib.const lib.hydraJob;
    mapHydra = lib.mapAttrsRecursiveCond (t: !(t ? test)) mkJob;
  in mapHydra (import ./tests {
    inherit system;
    pkgs = import nixpkgs {};
  });

  manual = let
    modules = import "${nixpkgs}/nixos/lib/eval-config.nix" {
      modules = [ ./modules ];
      check = false;
      inherit system;
    };

    isNcOpt = opt: lib.head (lib.splitString "." opt.name) == "nixcloud";
    filterDoc = lib.filter (opt: isNcOpt opt && opt.visible && !opt.internal);
    filtered = filterDoc (lib.optionAttrSetToDocList modules.options);
    # XXX: Instead of unsafe discard, let's actually strip the prefix someday.
    optionsXML = builtins.unsafeDiscardStringContext (builtins.toXML filtered);
    optionsFile = builtins.toFile "options.xml" optionsXML;

  in pkgs.stdenv.mkDerivation {
    name = "nixcloud-webservices-options";

    nativeBuildInputs = [ pkgs.libxslt ];

    buildCommand = ''
      dest="$out/share/doc/nixcloud-webservices"
      mkdir -p "$dest"

      cat > manual.xml <<XML
      <book xmlns="http://docbook.org/ns/docbook"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            xmlns:xi="http://www.w3.org/2001/XInclude">
        <title>NixOS options specific to nixcloud webservices</title>
        <xi:include href="options-db.xml" />
      </book>
      XML

      xsltproc -o options-db.xml \
        "${pkgs.path}/nixos/doc/manual/options-to-docbook.xsl" \
        ${lib.escapeShellArg optionsFile}

      xsltproc -o "$dest/index.html" -nonet -xinclude \
        --param section.autolabel 1 \
        --param section.label.includes.component.label 1 \
        --stringparam html.stylesheet style.css \
        --param xref.with.number.and.title 1 \
        --stringparam admon.style "" \
        ${pkgs.docbook5_xsl}/xml/xsl/docbook/xhtml/docbook.xsl \
        manual.xml

      cp "${pkgs.path}/nixos/doc/manual/style.css" "$dest/style.css"

      mkdir -p "$out/nix-support"
      echo "doc manual $dest" > "$out/nix-support/hydra-build-products"
    '';
  };
}
