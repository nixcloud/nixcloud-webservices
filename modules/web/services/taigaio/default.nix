{ config, pkgs, lib, mkUniqueUser, mkUniqueGroup, ... }:

with lib;

# https://raw.githubusercontent.com/betaboon/nixpkgs/445563d6575d7e8cb21768570b837ea3d816dee8/nixos/modules/services/web-apps/taiga.nix
# postgresql 10
# python 3.6.5 on ubuntu
# taiga-back   commit 4f5db05fae741b37608c0c964857bb3d668d067a (HEAD -> stable, tag: 3.3.13, origin/stable)
# taiga-front  commit 475619492e02a168cd7c31a85411830ffb26d754 (HEAD -> stable, tag: 3.3.13-stable, origin/stable)
# django 1.11.x is used

let
  taiga-back = pkgs.callPackage ./taiga-back.nix {};
  taiga-front = pkgs.callPackage ./taiga-front-dist.nix {};
  taiga-events = (pkgs.callPackage ./taiga-events/override.nix {}).TaigaIO-Events;

  # BUG global variable port 5672, make this allocated dynamically
  amqpUrl = "amqp://${config.amqp.user}:${config.amqp.password}@localhost:5672/${config.amqp.vhost}";

  httpScheme = ''${if config.proxyOptions.https.mode == "on" then "https" else "http"}'';
  wsScheme =   ''${if config.proxyOptions.https.mode == "on" then "wss" else "ws"}'';

  taigaBackConfigFile = pkgs.writeText "gaBackConfigFiletaiga-back-config-raw.py" ''
    from .common import *

    DATABASES = {
      'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'taigaio',
        'HOST': '${config.database.taigaio.socketPath}'
      }
    }
    MEDIA_ROOT = "${config.stateDir}/www/media"
    STATIC_ROOT = "${config.stateDir}/www/static"

    MEDIA_URL = "${httpScheme}://${config.urls.media}/"
    STATIC_URL = "${httpScheme}://${config.urls.static}/"

    SITES["front"]["scheme"] = "${httpScheme}"
    SITES["front"]["domain"] = "${config.urls.front}"

    PUBLIC_REGISTER_ENABLED = ${if config.enablePublicRegistration then "True" else "False"}

    SECRET_KEY = "${config.djangoSecret}"
    DEBUG = ${if config.enableDebug then "True" else "False"}

    ${optionalString config.enableWebsockets ''
      EVENTS_PUSH_BACKEND = "taiga.events.backends.rabbitmq.EventsPushBackend"
      EVENTS_PUSH_BACKEND_OPTIONS = {"url": "${amqpUrl}"}
    ''}
  '';

  taigaBackConfigPkg = pkgs.stdenv.mkDerivation rec {
    name = "taiga-back-config-package";
    # FIXME: (15:33) <betaboon> i guess you should define "python = pkgs.python3" somewhere. and then use ${taiga-back}/lib/${python.libPrefix}/site-packages/... instead

    buildCommand = ''
      mkdir -p $out/settings
      ln -s ${taiga-back}/lib/python3.6/site-packages/settings/*.py $out/settings/
      if [ ! -f $out/settings/__init__.py ]; then echo "failed to symlink the settings, please fix manually"; exit 1; fi
      ln -s ${taigaBackConfigFile} $out/settings/local.py
    '';
  };

  defaultFrontConfig = builtins.fromJSON (readFile "${taiga-front}/dist/conf.example.json");

  taigaFrontConfig = foldl recursiveUpdate defaultFrontConfig [
    { api =                   "${httpScheme}://${config.urls.api}";
      eventsUrl =             "${wsScheme}://${config.urls.events}";
      debug =                 config.enableDebug;
      publicRegisterEnabled = config.enablePublicRegistration;
      feedbackEnabled =       config.enableFeedback;
    }
    config.extraFrontConfig
  ];

  taigaFrontConfigFile = pkgs.writeText "taiga-front-config-raw.json" (builtins.toJSON taigaFrontConfig);

  defaultEventsConfig = builtins.fromJSON (readFile "${taiga-events}/lib/node_modules/TaigaIO-Events/config.example.json");

  taigaEventsConfig = foldl recursiveUpdate defaultEventsConfig [ {
    url = amqpUrl;
    secret = config.djangoSecret;
    # FIXME port
    webSocketServer = { port = 8888; };
  } ];

  taigaEventsConfigFile = pkgs.writeText "taiga-events-config-raw.json" (builtins.toJSON taigaEventsConfig);

in
{
  options = {
    enableDebug = mkOption {
      type = types.bool;
      default = true;
      description = "Enable debugging.";
    };

    enablePublicRegistration = mkOption {
      type = types.bool;
      default = false;
      description = "Enable public registration.";
    };

    enableFeedback = mkOption {
      type = types.bool;
      default = false;
      description = ""; # TODO check what this does
    };

    enableDjangoAdmin = mkOption {
      type = types.bool;
      default = false;
      description = "Enable django admin interface.";
    };

    enableWebsockets = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Websockets-Support.";
    };

    enableWsgi = mkOption {
      type = types.bool;
      default = false;
      description = "Enable WSGI-Support.";
    };

    wsgiWorkers = mkOption {
      type = types.int;
      default = 1; # FIXME increase to 3 later
      description = "Number of WSGI workers.";
    };

    # FIXME this whole url-set doesn't feel sane
    # FIXME: (qknignht) most can be removed
    urls = {
      # fixme: replace by proxyOptions.domain ...
      front = mkOption {
        type = types.string;
        default = "nix.lt";
        description = "Frontend URL";
      };
      api = mkOption {
        type = types.string;
        default = "nix.lt/api/v1";
        description = "API URL";
      };
      events = mkOption {
        type = types.str;
        default = "nix.lt/events";
        description = "Events URL";
      };
      static = mkOption {
        type = types.str;
        default = "nix.lt/static";
        description = "Static-Content URL";
      };
      media = mkOption {
        type = types.str;
        default = "nix.lt/media";
        description = "Media URL";
      };
    };

    extraFrontConfig = mkOption {
      type = types.attrs;
      default = { };
      description = ''
        Addtional configuration options as Nix attribute set in conf.json schema.
      '';
    };

    djangoSecret = mkOption {
      type = types.str;
      description = "Secret key for Django which is actually a salt.";
    };

    amqp = {
      user = mkOption {
        type = types.str;
        default = "taiga";
        description = "AMQP user (used for Websockets-support).";
      };
      password = mkOption {
        type = types.str;
        # FIXME this shouldn't have a default-value
        default = "PASSWORD";
        description = "AMQP password.";
      };
      vhost = mkOption {
        type = types.str;
        default = "taiga";
        description = "AMQP vhost.";
      };
    };
  };

  meta = {
    description = ''
      A project management platform for agile developers & designers
    '';
    homepage = "https://taiga.io";
    license = lib.licenses.agpl3;
    maintainers = with lib.maintainers; [ qknight ];
    meta.platforms = lib.platforms.linux;
  };

  config = lib.mkIf config.enable {

    directories.www.postCreate = ''
      mkdir media
      mkdir static
      mkdir temp 
    '';

    #database.taigaio.user = lib.traceVal config.webserver.user;
    database.taigaio.postCreate = let
      inherit (config.database.taigaio) type;
      python = pkgs.python3;
      penv = python.buildEnv.override {
        extraLibs = [
          taiga-back
          pkgs.python3Packages.gunicorn
          pkgs.python3Packages.gevent
          pkgs.python3Packages.psycopg2
	      ];
      };

    # FIXME: (15:33) <betaboon> i guess you should define "python = pkgs.python3" somewhere. and then use ${taiga-back}/lib/${python.libPrefix}/site-packages/... instead
    in if type == "postgresql" then ''
      export PYTHONPATH="${taigaBackConfigPkg}:${penv}/${python.sitePackages}/"
      cd ${taiga-back}/lib/python3.6/site-packages/ # FIXME: check if this is really needed
      ${taiga-back}/bin/manage.py migrate --noinput
      ${taiga-back}/bin/manage.py loaddata initial_user
      ${taiga-back}/bin/manage.py loaddata initial_project_templates
      ${taiga-back}/bin/manage.py compilemessages
      ${taiga-back}/bin/manage.py collectstatic --noinput
    '' else throw "Unsupported database type `${type}' for Taigaio.";

    users.taigaio = {
      description = "taigaio server user";
      home        = "${config.stateDir}/www";
      createHome  = true;
      group       = "taigaio";
    };

    groups.taigaio = {};

    systemd.services.taiga-back = rec {
     description = "${config.uniqueName} main service (taigaio)";

      wantedBy      = [ "multi-user.target" ];
      after         = [ "network.target" ];

      environment = let
        python = pkgs.python3;
        penv = python.buildEnv.override {
          extraLibs = [
            taiga-back
            pkgs.python3Packages.gunicorn
            pkgs.python3Packages.gevent
            pkgs.python3Packages.celery
            pkgs.python3Packages.django
          ];
        };
      in {
        #PYTHONPATH = "${penv}/${python.sitePackages}/:${taiga-back}/lib/python3.6/site-packages:${taigaBackConfigPkg}";
        PYTHONPATH = "${taigaBackConfigPkg}:${penv}/${python.sitePackages}/:${taiga-back}/lib/python3.6/site-packages:${pkgs.python3Packages.django}:${pkgs.python3Packages.celery}/lib/python3.6/site-packages/";
        DJANGO_SETTINGS_MODULE = "settings";
	#PATH = "$PATH:${pkgs.python3}/bin";
	#systemPackages = [ pkgs.python3 ];
      };

#taiga-back-3.3.13/lib/python3.6/site-packages
#4       /nix/store/d9i1q6xv61dv93hsv8bklkvn5nl2g7sc-taiga-back-3.3.13/lib/python3.6/site-packages/taiga/wsgi.py
#4       /nix/store/d9i1q6xv61dv93hsv8bklkvn5nl2g7sc-taiga-back-3.3.13/lib/python3.6/site-packages/taiga/__pycache__/wsgi.cpython-36.pyc

      serviceConfig = {
        User = "taigaio-t1";  # FIXME hardcoded
        Group = "taigaio-t1"; # FIXME hardcoded
        WorkingDirectory = "${taiga-back}/lib/python3.6/site-packages/taiga";
        #WorkingDirectory = "${config.stateDir}/www";
        PrivateTmp = false;
        # FIXME: hardcoded taigaio-t1 user/group
        # FIXME: port 8000 is hardcoded
	  #${pkgs.python3Packages.gunicorn}/bin/gunicorn taiga.wsgi \
    #           ${pkgs.python3Packages.gunicorn}/bin/gunicorn taiga:application \

	      #    --pythonpath=${taiga-back}/lib/python3.6/site-packages/taiga \
        ExecStart = 
         if config.enableWsgi then ''
	        ${pkgs.python3Packages.gunicorn}/bin/gunicorn taiga.wsgi \
            -k gevent \
            -u taigaio-t1 \
            -g taigaio-t1 \
	          --pythonpath=${lib.traceVal environment.PYTHONPATH} \
            --name gunicorn-taiga \
            --log-level ${if config.enableDebug then "debug" else "info"} \
            --workers ${toString config.wsgiWorkers} \
            --pid ${config.stateDir}/www/gunicorn-taiga.pid \
            --bind 127.0.0.1:8000
        '' else 
        # FIXME: check if that works
        ''
          ${taiga-back}/bin/manage.py runserver --nostatic "127.0.0.1:8000"
        '';
# /nix/store/d9i1q6xv61dv93hsv8bklkvn5nl2g7sc-taiga-back-3.3.13/lib/python3.6/site-packages/
        Restart = "always";
        PermissionsStartOnly = true;
        PrivateDevices = true;
        TimeoutSec = 300; # initial ./manage.py migrate can take a while
      };
    };

    # todo create abstraction in nixcloud-webservices for database rabbitmq
    #services.rabbitmq.enable = mkIf config.enableWebsockets true;

    systemd.services.taiga-events = mkIf config.enableWebsockets {
      description = "${config.uniqueName} Taiga Platform Server (Events)";

      wantedBy = [ "multi-user.target" ];
      #FIXME: correct taiga-back service name
      #requires = [ "network-online.target" "rabbitmq.service" "taiga-back.service" ];
      #after = [ "network-online.target" "rabbitmq.service" "taiga-back.service" ];
     
      requires = [ "network-online.target" ];
      after = [ "network-online.target" ];

      serviceConfig = {
        User  = "taigaio-t1";
        Group = "taigaio-t1";
        WorkingDirectory = "${config.stateDir}/www";
        ExecStart = ''
          ${pkgs.nodePackages.coffee-script}/lib/node_modules/coffee-script/bin/coffee \
          ${taiga-events}/lib/node_modules/TaigaIO-Events/index.coffee \
          --config ${taigaEventsConfigFile}
        '';

        Restart = "always";
        PermissionsStartOnly = true;
        PrivateDevices = true;
        PrivateTmp = true;
        TimeoutSec = 180;
      };

      #preStart = ''
      #  set -x
      #  if ! [ -e ${config.stateDir}/.rabbitmq-init ]; then
      #    ${pkgs.sudo}/bin/sudo -u rabbitmq ${pkgs.rabbitmq_server}/bin/rabbitmqctl \
      #      add_user ${config.amqp.user} ${config.amqp.password}
      #    ${pkgs.sudo}/bin/sudo -u rabbitmq ${pkgs.rabbitmq_server}/bin/rabbitmqctl \
      #      add_vhost ${config.amqp.vhost}
      #    ${pkgs.sudo}/bin/sudo -u rabbitmq ${pkgs.rabbitmq_server}/bin/rabbitmqctl \
      #      set_permissions -p ${config.amqp.vhost} ${config.amqp.user} ".*" ".*" ".*"
      #    touch ${config.stateDir}/.rabbitmq-init
      #  fi
      #'';
    };


  proxyOptions.websockets = {
    ws = {
      https.record = ''
        location /events {
          set $targetIP 127.0.0.1;
          set $targetPort 8888;
          # https websocket default flags
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
          proxy_set_header X-Forwarded-For $remote_addr;
          proxy_read_timeout 36000s;
          # required because of CORS
          proxy_set_header Host $host;
          proxy_pass http://$targetIP:$targetPort$request_uri;
        }'';
      subpath = "/events";
    };
  };

  webserver.variant = "nginx";
  webserver.nginx.extraConfig = ''
    client_max_body_size "50m";
    large_client_header_buffers 4 32k;
    charset utf-8;

    root ${taiga-front}/dist;

    try_files $uri $uri/ /index.html;

    # FIXME: hardcoded port
    location /api {
      proxy_pass http://127.0.0.1:8000/api;
    }

    location /static {
      alias ${config.stateDir}/www/static;
    }
    location /media {
      alias ${config.stateDir}/www/media;
    }
    location /conf.json {
      alias ${taigaFrontConfigFile};
    }
    '' +
    optionalString (config.enableDjangoAdmin) ''
    location /admin = {
      proxyPass "http://127.0.0.1:8000$request_uri";
    }
  '';

#    tests.wanted = [ ./test.nix ];
  };
}
