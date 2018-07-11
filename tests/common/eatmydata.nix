{ config, lib, pkgs, ... }:

let
  perWS = lib.const (cfg: let
    enabledDbs = lib.optionalAttrs cfg.enable cfg.database;
    dbs = lib.mapAttrsToList (lib.const (db: db.type)) enabledDbs;
    value.environment.LD_PRELOAD = "${pkgs.libeatmydata}/lib/libeatmydata.so";
  in lib.optional (lib.elem "mysql" dbs) {
    name = "${cfg.uniqueName}-mysql";
    inherit value;
  } ++ lib.optional (lib.elem "postgresql" dbs) {
    name = "${cfg.uniqueName}-postgresql";
    inherit value;
  });

  perWSName = lib.const (cfg: lib.concatLists (lib.mapAttrsToList perWS cfg));
  serviceList = lib.mapAttrsToList perWSName config.nixcloud.webservices;

in {
  systemd.services = lib.listToAttrs (lib.concatLists serviceList);
}
