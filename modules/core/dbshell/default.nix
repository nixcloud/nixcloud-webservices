{ config, pkgs, lib, nclib, ... }:

let
  toPython = value: let
    mkStr = val: "'${lib.escape ["'" "\\"] val}'";
    mkDict = attrs: let
      mkEntry = key: val: "${mkStr key}: ${toPython val}";
      entries = lib.mapAttrsToList mkEntry attrs;
    in "{${lib.concatStringsSep "," entries}}";
    mkTuple = lib.concatMapStringsSep "," toPython;
  in if value == true then "True"
     else if value == false then "False"
     else if lib.isAttrs value then mkDict value
     else if lib.isString value then mkStr value
     else if lib.isInt value then toString value
     else if lib.isList value then mkTuple value
     else throw "Can't convert '${value}' into a Python value.";

  dbshellConfig = nclib.mapWSConfigToList (cfg: lib.optional cfg.enable {
    name = cfg.uniqueName;
    value = lib.mapAttrs' (lib.const (dbcfg: {
      inherit (dbcfg) name;
      value = {
        user = cfg._module.args.mkUniqueUser dbcfg.user;
        command = let
          inherit (dbcfg) type;
          errMsg = "Unable to determine database shell access command"
                 + " for database type '${type}'.\n"
                 + "Please define 'dbShellCommand' in your database module.";
        in toString (pkgs.writeScript "dbshell-${type}.sh" ''
          #!${pkgs.stdenv.shell} -e
          ${cfg.dbShellCommand.${type} or (throw errMsg)}
        '');
      };
    })) cfg.database;
  });

  wrapper = pkgs.runCommand "nixcloud-dbshell" {
    sourceFile = ./dbshell.py;
    dbshellConfig = toPython (lib.listToAttrs (lib.concatLists dbshellConfig));
    inherit (pkgs.python3Packages.python) interpreter;
  } ''
    mkdir -p "$out/bin"
    substituteAll "$sourceFile" "$out/bin/nixcloud-dbshell"
    chmod +x "$out/bin/nixcloud-dbshell"
  '';

in {
  environment.systemPackages = [ wrapper ];
}
