{ config, toplevel, pkgs, lib, mkUniqueUser, mkUniqueGroup, ... }:

let
  hydraEnv = {
    HYDRA_DBI = "dbi:Pg:dbname=hydra;user=${mkUniqueUser "hydra"};"
              + "host=${config.database.hydra.socketPath}";
    # TODO: gc_roots_dir!
    HYDRA_CONFIG = let
      inherit (config.proxyOptions) domain path;
      inherit (toplevel.config.nixcloud.reverse-proxy) httpPort httpsPort;
      isHttps = config.proxyOptions.https.mode != "off";
      scheme = if isHttps then "https" else "http";
      # XXX: This really should be passed through by the either the reverse
      # proxy or some common interface in the core of the webservices.
      maybePort = let
        mkMaybePort = p: d: lib.optionalString (p != d) ":${toString p}";
        maybeHttpPort = mkMaybePort httpPort 80;
        maybeHttpsPort = mkMaybePort httpsPort 443;
      in if isHttps then maybeHttpsPort else maybeHttpPort;
      baseURI = "${scheme}://${domain}${maybePort}${path}";
    in pkgs.writeText "hydra.conf" ''
      using_frontend_proxy = 1
      base_uri = ${baseURI}
      max_servers = 25
      compress_num_threads = 0
      use-substitutes = ${if config.useSubstitutes then "1" else "0"}
    '';
    HYDRA_DATA = config.stateDir;
    IN_SYSTEMD = "1"; # To get log severity levels for the journal
  };

in {
  options = {
    package = lib.mkOption {
      type = lib.types.path;
      default = pkgs.hydra;
      description = "The Hydra package to use.";
    };

    useSubstitutes = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to use binary caches for downloading store paths. Note that
        binary substitutions trigger (a potentially large number of) additional
        HTTP requests that slow down the queue monitor thread significantly.
        Also, this Hydra instance will serve those downloaded store paths to
        its users with its own signature attached as if it had built them
        itself, so don't enable this feature unless your active binary caches
        are absolute trustworthy.
      '';
    };

    initialAdminUser = lib.mkOption {
      type = lib.types.str;
      default = "admin";
      description = ''
        The initial user to create which has administrative privileges and can
        create more users.
      '';
    };

    initialAdminPassword = lib.mkOption {
      type = lib.types.str;
      description = ''
        The password of the initial admin user specified by
        <option>initialAdminUser</option>.

        <note><para>This password will be placed into the Nix store, which is
        readable by all users of the system. Even though it will be stored
        there in hashed form, it's not salted so be sure to change it as soon
        as possible.</para></note>
      '';
    };
  };

  config = lib.mkIf config.enable {
    groups.hydra = {};

    users.hydra = {
      description = "Hydra";
      group = "hydra";
      createHome = true;
      home = config.stateDir;
    };

    users.hydra-queue-runner = {
      description = "Hydra queue runner";
      group = "hydra";
      createHome = true;
      home = "${config.stateDir}/queue-runner";
    };

    users.hydra-www = {
      description = "Hydra web server";
      createHome = true;
      group = "hydra";
      home = "${config.stateDir}/www";
    };

    directories.build-logs = {
      owner = mkUniqueUser "hydra-queue-runner";
      group = mkUniqueGroup "hydra";
      permissions.others.noAccess = true;
    };

    # Hydra only supports PostgreSQL
    database.hydra.type = "postgresql";
    database.hydra.owners = [ "hydra-queue-runner" "hydra-www" ];

    # XXX: Make sure to change this for separate Nix instances.
    toplevel.nix.trustedUsers = [ (mkUniqueGroup "hydra-queue-runner") ];

    systemd.services.hydra-init = {
      description = "Hydra Initialisation";
      environment = hydraEnv;
      instance.after = [ "database.target" ];
      serviceConfig.ExecStart = "${config.package}/bin/hydra-init";
      serviceConfig.User = "hydra";
      serviceConfig.Type = "oneshot";
      serviceConfig.RemainAfterExit = true;

      postStart = let
        hashedPw = builtins.hashString "sha1" config.initialAdminPassword;
      in ''
        if [ ! -e ${lib.escapeShellArg config.stateDir}/.init-done ]; then
          ${lib.escapeShellArg config.package}/bin/hydra-create-user \
            ${lib.escapeShellArg config.initialAdminUser} \
            --password-hash ${lib.escapeShellArg hashedPw} \
            --role admin
          touch ${lib.escapeShellArg config.stateDir}/.init-done
        fi
      '';
    };

    systemd.services.hydra-server = {
      description = "Hydra Server";
      wantedBy = [ "multi-user.target" ];

      instance.requires = [ "hydra-init.service" ];
      instance.after = [ "hydra-init.service" ];

      environment = hydraEnv;

      serviceConfig = {
        ExecStart = let
          args = lib.concatMapStringsSep " " lib.escapeShellArg [
            # FIXME: Let's use sockets here once we have support for them in
            #        the reverse proxy.
            "-f" "-h" config.proxyOptions.ip
            "-p" (toString config.proxyOptions.port)
            #"--max_spare_servers" "5" # XXX
            #"--max_servers" "25" # XXX
          ];
        in "@${config.package}/bin/hydra-server hydra-server ${args}";
        User = "hydra-www";
        Restart = "on-failure";
      };
    };

    systemd.services.hydra-queue-runner = {
      description = "Hydra Queue Runner";
      wantedBy = [ "multi-user.target" ];

      instance.requires = [ "hydra-init.service" ];
      instance.after = [ "hydra-init.service" ];

      environment = hydraEnv;
      path = [
        config.package pkgs.nettools pkgs.openssh pkgs.bzip2
        toplevel.config.nix.package
      ];

      serviceConfig = {
        ExecStart = "@${config.package}/bin/hydra-queue-runner"
                  + " hydra-queue-runner -v";
        ExecStopPost = "${config.package}/bin/hydra-queue-runner --unlock";
        User = "hydra-queue-runner";
        Restart = "always"; # XXX!
        WorkingDirectory = "~";
      };
    };

    # TODO: Make this DRY with the queue runner
    systemd.services.hydra-evaluator = {
      description = "Hydra Evaluator";
      wantedBy = [ "multi-user.target" ];

      instance.requires = [ "hydra-init.service" ];
      instance.after = [ "hydra-init.service" ];

      environment = hydraEnv;
      path = [ pkgs.nettools config.package pkgs.jq ];

      serviceConfig = {
        ExecStart = "@${config.package}/bin/hydra-evaluator"
                  + " hydra-evaluator -v";
        ExecStopPost = "${config.package}/bin/hydra-evaluator --unlock";
        User = "hydra";
        Restart = "always"; # XXX!
        WorkingDirectory = "~";
      };
    };

    tests.wanted = [ ./test.nix ];
  };

  meta.license = lib.licenses.gpl3Plus;
}
