{ config, pkgs, lib, options, wsName, mkUnique, ... }:

with lib;

{
  options.webserver.nginx = {
    # FIXME: add package as in apache
    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = ''
        Cnfiguration lines appended to the generated Nginx
        configuration file.
      '';
    };
    extraServiceDependencies = mkOption {
      type = types.listOf types.str;
      default = [ ];
      example = [ "postgresql.service" ];
      description = "Makes it easy to replace postgresql by mysql and depend on the service before we start the webservice.";
    };
  };

  config = let
    fastcgi_params = pkgs.writeText "fastcgi_params.conf" ''
      fastcgi_param   QUERY_STRING            $query_string;
      fastcgi_param   REQUEST_METHOD          $request_method;
      fastcgi_param   CONTENT_TYPE            $content_type;
      fastcgi_param   CONTENT_LENGTH          $content_length;

      fastcgi_param   SCRIPT_FILENAME         $document_root$fastcgi_script_name;
      fastcgi_param   SCRIPT_NAME             $fastcgi_script_name;
      fastcgi_param   PATH_INFO               $fastcgi_path_info;
      fastcgi_param   PATH_TRANSLATED         $document_root$fastcgi_path_info;
      fastcgi_param   REQUEST_URI             $request_uri;
      fastcgi_param   DOCUMENT_URI            $document_uri;
      fastcgi_param   DOCUMENT_ROOT           $document_root;
      fastcgi_param   SERVER_PROTOCOL         $server_protocol;

      fastcgi_param   GATEWAY_INTERFACE       CGI/1.1;
      fastcgi_param   SERVER_SOFTWARE         nginx/$nginx_version;

      fastcgi_param   REMOTE_ADDR             $remote_addr;
      fastcgi_param   REMOTE_PORT             $remote_port;
      fastcgi_param   SERVER_ADDR             $server_addr;
      fastcgi_param   SERVER_PORT             $server_port;
      fastcgi_param   SERVER_NAME             $server_name;

      #fastcgi_param   HTTPS                   $https;

      # PHP only, required if PHP was built with --enable-force-cgi-redirect
      fastcgi_param   REDIRECT_STATUS         200;
    '';
  in mkIf (config.webserver.variant == "nginx" && config.enable) {

    directories = lib.genAttrs [ "nginx" "nginx/logs" ] (lib.const {
      owner = mkUnique config.webserver.user;
      group = mkUnique config.webserver.group;
      instance.before = [ "webserver-init.service" "instance-init.target" ];
    });

    systemd.services.nginx = let
      fileName = "${config.uniqueName}.conf";
    in {
      description = "Nginx HTTPD";
      wantedBy      = [ "multi-user.target" ];
      after = [ "network.target" "fs.target" "keys.target" ] ++ config.webserver.nginx.extraServiceDependencies;
      instance.after = [ "database.target" "webserver-init.service" ];
      serviceConfig = let
        checkAndFormatNginxConfigfile = (import lib/nginx_check_config.nix {inherit lib pkgs;}).checkAndFormatNginxConfigfile {configFile = nginxConfigFile; inherit fileName;};

        # FIXME: add user record only if run as root (which is not the case if PermissionsStartOnly=false IIRC)
        nginxConfigFile = pkgs.writeText "${config.uniqueName}.conf" ''
          user "${mkUnique config.webserver.user}" "${mkUnique config.webserver.group}";
          error_log stderr;
          daemon off;
          events {}

          http {
            server {
              #listen unix:/var/run/nginx.sock;
              listen ${toString config.proxyOptions.port};
              access_log ${config.stateDir}/nginx/logs/access.log;
              error_log ${config.stateDir}/nginx/logs/error.log;
              server_name "${config.proxyOptions.domain}";

              ${config.webserver.nginx.extraConfig}
            }
          }
        '';

      in {
        ExecStart = "${pkgs.nginx}/bin/nginx -c ${checkAndFormatNginxConfigfile}/${fileName} -p ${config.stateDir}/nginx";
        ExecReload  = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
        PIDFile = "${config.runtimeDir}/nginx.pid";

        Restart = "always";
        RestartSec = "10s";
        StartLimitInterval = "1min";
        User = config.webserver.user;
        Group = config.webserver.group;
        PermissionsStartOnly=true;
        PrivateTmp=config.webserver.privateTmp;
      };
    };
  };
}
