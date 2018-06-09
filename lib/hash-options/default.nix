# Recursively hashes all options so that it can be used for comparing a
# specific option interface against another.
{ lib ? import <nixpkgs/lib> }:

let
  # Make sure that all the information about a type is present without the need
  # to evaluate lambdas (which we can't hash).
  cleanType = type: let
    inherit (type.functor) wrapped;
  in {
    inherit (type) name description;
    wrapped = lib.mapNullable cleanType wrapped;
  };

  # This recursively walks through all the options and submodules to generate a
  # structure that can be safely transformed into JSON.
  walk = path: opt: let
    sanitize = { type, ... }@attrs: {
      inherit path;
      default = attrs.default or null;
      type = cleanType type;
      subOptions = walk path (type.getSubOptions path);
    };
    recurse = name: walk (path ++ lib.singleton name);
    mapNested = lib.concatLists (lib.mapAttrsToList recurse opt);
  in if lib.isOption opt then lib.singleton (sanitize opt)
     else if lib.isAttrs opt then mapNested
     else [];

  hashAttrs = x: builtins.hashString "sha256" (builtins.toJSON x);
  hashOptions = x: hashAttrs (walk [] x);

in hashOptions
