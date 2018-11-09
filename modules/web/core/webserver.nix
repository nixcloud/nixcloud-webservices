# This submodule contains all of the option declarations and definitions that
# are common among all web server modules.
#
{ toplevel, name, config, pkgs, lib, ... }:

let
  needsWebServerInit = config.webserver.init != ""
                    || config.webserver.startupScript != "";
in {
  options = {
    proxyOptions = lib.mkOption {
      default = {};
      type = lib.types.submodule (import ../../services/reverse-proxy/options.nix);
      description = "";
      example = {
        port   = 3333;
        path   = "/tour";
        domain = "nixcloud.io";
        ip     = "127.0.0.1";
      };
    };
   
    webserver.systemPackages = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [];
      description = ''
        Used to add useful scripts for webservice management into the system
        profile by using <option>environment.systemPackages</option>
      '';
    };

    webserver.startupScript = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Commands that are run prior to starting the actual web server using the
        privileges of the user defined in <option>webserver.user</option>.

        <note><para>These commands are run directly after
        <option>serverInit</option> but before the actual
        web server.</para></note>
      '';
    };

    webserver.init = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Commands that are run prior to starting the actual web server.

        <note><para>These commands are run as the <systemitem
        class="username">root</systemitem> user.</para></note>
      '';
    };

    webserver.user = lib.mkOption {
      default = "webserver";
      type = lib.types.str;
      description = "The main user name which executes this webservice.";
    };

    webserver.userOptions = lib.mkOption {
      default = {};
      type = let
        submodules = toplevel.options.users.users.type.getSubModules;
      in lib.types.submodule (map (m: m.submodule) submodules);
      description = ''
        Additional options for the user, see <option>users.users</option> for
        possible values.
      '';
    };

    webserver.group = lib.mkOption {
      default = "webserver";
      type = lib.types.str;
      description = "The main group name which executes this webservice.";
    };

    webserver.groupOptions = lib.mkOption {
      default = {};
      type = let
        submodules = toplevel.options.users.groups.type.getSubModules;
      in lib.types.submodule (map (m: m.submodule) submodules);
      description = ''
        Additional options for the group, see <option>users.groups</option> for
        possible values.
      '';
    };

    webserver.privateTmp = lib.mkOption {
      default = true;
      example = false;
      description = ''
        Weather to force the webservice to use a private
        <filename>/tmp</filename> instance.

        <warning><para>
        If postgresql stores the socket context in <filename>/tmp</filename>
        you have to say <literal>false</literal> here or it can't be used at
        all.
        </para></warning>
      '';
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.enable {
      toplevel.assertions = [
        { assertion = config.proxyOptions.path != "";
          message = "proxyOptions.path must not be an empty string";
        }
        { assertion = config.proxyOptions.domain != "";
          message = "proxyOptions.domain must not be an empty string";
        }
      ];




      users.${config.webserver.user} = {
        inherit (config.webserver) group;
      } // removeAttrs config.webserver.userOptions [ "name" "group" ];

      groups.${config.webserver.group} =
        removeAttrs config.webserver.groupOptions [ "name" ];
    })
    (lib.mkIf (config.enable && needsWebServerInit) {
      systemd.services.webserver-init = {
        description = "Web Server Initialization";
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" "fs.target" "keys.target" ];
        instance.after = [ "database.target" ];

        serviceConfig.Type = "oneshot";
        serviceConfig.RemainAfterExit = true;
      } // (if config.webserver.startupScript == "" then {
        script = config.webserver.init;
      } else {
        preStart = config.webserver.init;
        script = config.webserver.startupScript;

        serviceConfig.Type = "oneshot";
        serviceConfig.User = config.webserver.user;
        serviceConfig.Group = config.webserver.group;
        serviceConfig.PermissionsStartOnly = true;
        serviceConfig.RemainAfterExit = true;
      });
    })
  ];
}
