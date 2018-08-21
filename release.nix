{ system ? builtins.currentSystem, nixpkgs ? <nixpkgs>

# This is a self-reference, so be sure to call the Hydra jobset input
# 'nixcloud-webservices', otherwise the version will be wrong.
, nixcloud-webservices ? { outPath = ./.; revCount = 1234; rev = "abcdef"; }
}:

let
  pkgs = import nixpkgs { inherit system; };
  inherit (pkgs) lib;

  tests = let
    mkJob = lib.const lib.hydraJob;
    mapHydra = lib.mapAttrsRecursiveCond (t: !(t ? test)) mkJob;
  in mapHydra (import ./tests {
    inherit system nixpkgs;
    pkgs = import nixpkgs {};
  });

  manual = let
    modules = import "${nixpkgs}/nixos/lib/eval-config.nix" {
      modules = [ ./modules ];
      check = false;
      inherit system;
    };

  unknownModule = "<unknown-file>";

  #coppy of the lib function from nixpkgs with a small change that checks with builtins.tryEval 
  #if a value can be evaluated before using them.
  #FIXME use the original function (find a better way to do this)
  optionAttrSetToDocList = optionAttrSetToDocList' [];
  optionAttrSetToDocList' = prefix: options:
    lib.concatMap (opt:
      with lib.attrsets; let
        docOption = rec {
          loc = opt.loc;
          name = lib.showOption opt.loc;
          description = opt.description or (throw "Option `${name}' has no description.");
          declarations = lib.filter (x: x != unknownModule) opt.declarations;
          internal = opt.internal or false;
          visible = opt.visible or true;
          readOnly = opt.readOnly or false;
          type = opt.type.description or null;
        }
        // optionalAttrs (opt ? example) { example = lib.scrubOptionValue opt.example; }
        // optionalAttrs (opt ? default) { default = scrubOptionValue opt.default; }
        // optionalAttrs (opt ? defaultText) { default = opt.defaultText; }
        // optionalAttrs (opt ? relatedPackages && opt.relatedPackages != null) { inherit (opt) relatedPackages; };

        subOptions =
          let ss = opt.type.getSubOptions opt.loc;
          in if ss != {} then optionAttrSetToDocList' opt.loc ss else [];
      in
        [ docOption ] ++ subOptions) (lib.collect lib.isOption options);
  #another copy of a buildin function 
  /* This function recursively removes all derivation attributes from
     `x' except for the `name' attribute.  This is to make the
     generation of `options.xml' much more efficient: the XML
     representation of derivations is very large (on the order of
     megabytes) and is not actually used by the manual generator. */
  scrubOptionValue = x:
    if (builtins.tryEval x).success then
      if ( (lib.isDerivation x)) then
        { type = "derivation"; drvPath = x.name; outPath = x.name; name = x.name; }
      else if lib.isList x then map scrubOptionValue x
      else if lib.isAttrs x then lib.mapAttrs (n: v: scrubOptionValue v) (removeAttrs x ["_args"])
      else x
    else "`?`";


    isNcOpt = opt: lib.head (lib.splitString "." opt.name) == "nixcloud";
    filterDoc = lib.filter (opt: isNcOpt opt && opt.visible && !opt.internal);
    filtered = filterDoc (optionAttrSetToDocList modules.options);
    # XXX: Instead of unsafe discard, let's actually strip the prefix someday.
    optionsXML = builtins.unsafeDiscardStringContext (builtins.toXML filtered);
    optionsFile = builtins.toFile "options.xml" optionsXML;

  in pkgs.stdenv.mkDerivation {
    name = "nixcloud-webservices-options";

    nativeBuildInputs = [ pkgs.libxslt ];

    styleSheets = [
      "style.css" "overrides.css" "highlightjs/mono-blue.css"
    ];

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
        --stringparam html.stylesheet \
          'style.css overrides.css highlightjs/mono-blue.css' \
        --stringparam html.script \
          'highlightjs/highlight.pack.js highlightjs/loader.js' \
        --param xref.with.number.and.title 1 \
        --stringparam admon.style "" \
        ${pkgs.docbook5_xsl}/xml/xsl/docbook/xhtml/docbook.xsl \
        manual.xml

      cp "${nixpkgs}/doc/style.css" "$dest/style.css"
      cp "${nixpkgs}/doc/overrides.css" "$dest/overrides.css"
      cp -r ${pkgs.documentation-highlighter} "$dest/highlightjs"

      mkdir -p "$out/nix-support"
      echo "doc manual $dest" > "$out/nix-support/hydra-build-products"
    '';
  };

  # All the jobs excluding the channel, because they will be constituents for
  # the channel.
  jobs = {
    inherit tests manual;
  };

in jobs // {
  # This is the channel and it is called 'nixcloud-webservices' to ensure that
  # when the channel is added without an explicit name argument, it will be
  # available as <nixcloud-webservices>.
  nixcloud-webservices = pkgs.releaseTools.channel {
    name = "nixcloud-webservices";
    constituents = lib.collect lib.isDerivation jobs;
    src = nixcloud-webservices;
    patchPhase = ''
      touch .update-on-nixos-rebuild
      cat > default.nix <<EOF
      { imports = [ ./modules ];
        nixcloud.version = "${nixcloud-webservices.rev}";
      }
      EOF
    '';
  };
}
