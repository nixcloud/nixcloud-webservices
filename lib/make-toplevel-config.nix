{ config, options, lib }:

# Generate configuration values by avoiding to trigger an infinite recursion
# of the `config' fixpoint.
#
# The first argument is a function Config -> [AttrSet] which returns a list of
# all the top-level definitions, like for example:
#
#   [ { systemd.services.foo = { description = "bar"; ... }; }
#     { environment.etc.bar.source = ...; }
#   ]
#
# The second argument is a path of the configuration value to map the function
# from the first argument on. For example if the path is ["foo" "bar"], the
# function will be applied like this:
#
#   map fun config.foo.bar
#
# We need this to be a path instead of a plain attribute, because we need to
# look up the same path in options to figure out on which values we can't
# recurse on (like the configuration value of that path itself).
#
fun: cfgval: let
  # These are the configuration paths we don't want to reference, because
  # if we do, we would trip the fixpoint and trigger an infinite
  # recursion.
  unsafePaths = [
    # For injecting args to modules, so it's a very obvious contender.
    ["_module"]
    # Here we have checkConfigurationOptions, which is an alias of
    # _module.check.
    ["environment"]
    # The common namespace for NixCloud.
    ["nixcloud"]
  ];

  # Put in all values of environment.* except checkConfigurationOptions.
  safePaths = let
    reEval = import <nixpkgs/nixos/lib/eval-config.nix> {
      inherit (config.nixpkgs.localSystem) system;
      modules = [];
      check = false;
    };
    safeEnvOpts = lib.attrNames (removeAttrs reEval.options.environment [
      "checkConfigurationOptions"
    ]);
  in map (p: ["environment" p]) safeEnvOpts;

  mkThunks = acc: path: let
    inherit (builtins) attrNames head tail;
    # Get all singletons into right and everything else in wrong.
    inherit (lib.partition (e: builtins.length e == 1) acc) right wrong;
    # The flattened elements from the list of singletons.
    singletons = map head right;
    # Top-level attributes that can safely be included.
    top = removeAttrs (lib.getAttrFromPath path options) singletons;
    # All the leaves we no longer need to recurse into.
    leaves = map (n: path ++ [ n ]) (attrNames top);
    # However, we want to recurse into 'wrong' (non-leaves) so that we
    # have an attribute set of the first elements as names and a list of
    # all the successive elements as values.
    sorted = lib.zipAttrs (map (e: { ${head e} = tail e; }) wrong);
    # Recurse further into each node, appending the current node to path.
    recurse = node: rest: mkThunks rest (path ++ [ node ]);
  in leaves ++ builtins.concatLists (lib.mapAttrsToList recurse sorted);

  # Map over each list item `fun' returns and generate attribute setters
  # for each path that is *not* listed in unsafePaths.
  unbox = path: let
    foldThunks = defs: acc: let
      maybePath = lib.optional (lib.hasAttrByPath path defs);
    in acc ++ maybePath (lib.getAttrFromPath path defs);
    eval = fun (lib.getAttrFromPath cfgval config);
  in lib.setAttrByPath path (lib.mkMerge (lib.fold foldThunks [] eval));

in lib.mkMerge (map unbox ((mkThunks unsafePaths []) ++ safePaths))
