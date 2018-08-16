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

   myPythonPackages = with pkgs.python3Packages; rec {
      asana = buildPythonPackage rec {
        pname = "asana";
        version = "0.6.2";
        name = "${pname}-${version}";
     
        src = fetchPypi {
          inherit pname version;
          sha256 = "0skai72392n3i1c4bl3hn2kh5lj990qsbasdwkbjdcy6vq57jggf";
        };
       
        buildInputs = [ pytest ];
        propagatedBuildInputs = [ requests requests_oauthlib six ];
      
        patchPhase = ''
          echo > requirements.txt
          sed -i "s/requests~=2.9.1/requests >=2.9.1/" setup.py
          sed -i "s/six~=1.10.0/six>=1.10.0/" setup.py
          sed -i "s/requests_oauthlib~=0.6.1/requests_oauthlib >=0.6.1/" setup.py
        '';
   
        # ERROR: file not found: tests
        doCheck = false;
       
        checkPhase = ''
          py.test tests
        '';
       
        meta = {
          description = "Python client library for Asana";
          homepage = https://github.com/asana/python-asana;
          license = lib.licenses.mit;
        };
      };
     diff-match-patch = buildPythonPackage rec {
       pname = "diff-match-patch";
       name = "${pname}-${version}";
       
       version = "20121119";
         
       src = fetchPypi {
        inherit pname version;
        sha256 = "0k1f3v8nbidcmmrk65m7h8v41jqi37653za9fcs96y7jzc8mdflx";
      };
       meta = {
        homepage = https://code.google.com/p/google-diff-match-patch/;
        description = "Diff, Match and Patch libraries for Plain Text";
         license = lib.licenses.asl20;
      };
   };  
    django-ipware = buildPythonPackage rec {
       pname = "django-ipware";
       name = "${pname}-${version}";
       version = "1.1.6";

       src = fetchPypi {
         inherit pname version;
         sha256 = "00zah4g2h93nbsijz556j97v9qkn9sxcia1a2wrwdwnav2fhzack";
       };

       propagatedBuildInputs = [ django ];

       # django.core.exceptions.ImproperlyConfigured: Requested setting IPWARE_TRUSTED_PROXY_LIST, but settings are not 
       doCheck = false;

       meta = {
         description = "A Django application to retrieve user's IP address";
         homepage = https://github.com/un33k/django-ipware;
         license = lib.licenses.mit;
       };
     };

     django-jinja = buildPythonPackage rec {
       pname = "django-jinja";
       name = "${pname}-${version}";
       version = "2.2.2";

       src = fetchPypi {
         inherit pname version;
         sha256 = "099b99iprkvlsndrjmw4v3i3i60i9gm1aq5r88z15r7vgmv6sigj";
       };

       buildInputs = [ django pytz tox ];
       propagatedBuildInputs = [ django jinja2 ];

       # python installed: The directory '/homeless-shelter/.cache/pip/http' or its parent directory is not owned by the 
       #sudo's -H 
       doCheck = false;
       checkPhase = ''
         tox
       '';

       meta = {
         description = "Simple and nonobstructive jinja2 integration with Django";
         homepage = https://github.com/niwinz/django-jinja;
         license = lib.licenses.bsd3;
       };
     };

    django-pglocks = buildPythonPackage rec {
       pname = "django-pglocks";
       name = "${pname}-${version}";
       version = "1.0.2";

       src = fetchPypi {
         inherit pname version;
         sha256 = "1ks4k0bk4457wfl3xgzr4v7xb0lxmnkhxwhlp0bbnmzipdafw1cl";
       };

       buildInputs = [ django ];
       propagatedBuildInputs = [ django ];

       # tests need a postgres database
       doCheck = false;

       meta = {
         description = "PostgreSQL locking context managers and functions for Django.";
         homepage = https://github.com/Xof/django-pglocks;
         license = lib.licenses.mit;
       };
     };

    django-picklefield = buildPythonPackage rec {
       pname = "django-picklefield";
       name = "${pname}-${version}";
       version = "0.3.2";

       src = fetchPypi {
         inherit pname version;
         sha256 = "1qlsbp3798ii68ny9zlz2ppkna00jf7i4hmjal3p8433gi18md7s";
       };

       meta = {
         description = "A pickled object field for Django";
         homepage = https://github.com/gintas/django-picklefield;
         license = lib.licenses.mit;
       };
     };
   django-sampledatahelper = buildPythonPackage rec {
       pname = "django-sampledatahelper";
       name = "${pname}-${version}";
       version = "0.4.1";

       src = fetchPypi {
         inherit pname version;
         sha256 = "1795zg73lajcsfyd8i8cprb2v93d4csifjnld6bfnya90ncsbl4n";
       };

       buildInputs = [ django nose pillow sampledata six versiontools ];
       propagatedBuildInputs = [ django sampledata ];

       # HACK To prevent collision with pythonPackages.sampledata
       preBuild = ''
         rm tests/*
       '';

       # ERROR: test_image_from_directory (tests.tests.TestImageHelpers)
       doCheck = false;

       meta = {
         description = "Helper class for generate sample data for django apps development";
         homepage = https://github.com/kaleidos/django-sampledatahelper;
         license = lib.licenses.bsd3;
       };
     };

    django-sites = buildPythonPackage rec {
       pname = "django-sites";
       name = "${pname}-${version}";
       version = "0.9";

       src = fetchPypi {
         inherit pname version;
         sha256 = "05nrydk4a5a99qrxjrcnacs8nbbq5pfjikdpj4w9yn5yfayp057s";
       };

       propagatedBuildInputs = [ django ];

       # django.core.exceptions.ImproperlyConfigured: Requested settings, but settings are not configured. You must either 
       doCheck = false;

       meta = {
         description = ''
           Alternative implementation of django "sites" framework
           based on settings instead of models.
         '';
         homepage = https://github.com/niwinz/django-sites;
         license = lib.licenses.bsd3;
       };
     };

    django-sr = buildPythonPackage rec {
       pname = "django-sr";
       name = "${pname}-${version}";
       version = "0.0.4";

       src = fetchPypi {
         inherit pname version;
         sha256 = "0d3yqppi1q3crcn9nxx58wzm4yw61d5m7435g6rb9wcamr9bi1im";
       };

       buildInputs = [ django nose ];
       propagatedBuildInputs = [ django ];

       meta = {
         description = "Django settings resolver";
         homepage = https://github.com/jespino/django-sr;
         license = lib.licenses.bsd3;
       };
     };

    djmail = buildPythonPackage rec {
       pname = "djmail";
       name = "${pname}-${version}";
       version = "1.0.1";

       src = fetchPypi {
         inherit pname version;
         sha256 = "1827i9qcn1ki09i5pg0lmar7cxjv18avh76x1n20947p1cimf3rp";
       };

       propagatedBuildInputs = [ celery django psycopg2 ];

       # django.core.exceptions.ImproperlyConfigured: Requested setting DEFAULT_INDEX_TABLESPACE, but settings are not 
       doCheck = false;

       meta = {
         description = "Simple, powerfull and nonobstructive django email middleware.";
         homepage = https://github.com/bameda/djmail;
         license = lib.licenses.bsd3;
       };
     };
    easy-thumbnails = buildPythonPackage rec {
       pname = "easy-thumbnails";
       name = "${pname}-${version}";
       version = "2.4.1";

       src = fetchPypi {
         inherit pname version;
         sha256 = "0w228b6hx8k4r15v7z62hyg99qp6xp4mdkgqs1ah64fyqxp1riaw";
       };

       propagatedBuildInputs = [ django pillow ];

       meta = {
         description = "Easy thumbnails for Django";
         homepage = https://github.com/SmileyChris/easy-thumbnails;
         license = lib.licenses.bsd3;
       };
     };

    fn = buildPythonPackage rec {
       pname = "fn";
       name = "${pname}-${version}";
       version = "0.4.3";

       src = fetchPypi {
         inherit pname version;
         sha256 = "1nmsjmn8jb4gp22ksx0j0hhdf4y0zm8rjykyy2i6flzimg6q1kgq";
       };

       meta = {
         description = "Functional programming in Python: implementation of missing features to enjoy FP";
         homepage = https://github.com/kachayev/fn.py;
         license = lib.licenses.asl20;
       };
     };

    premailer = buildPythonPackage rec {
       pname = "premailer";
       name = "${pname}-${version}";
       version = "3.0.1";

       src = fetchPypi {
         inherit pname version;
         sha256 = "0cmlvqx1dvy16k5q5ylmr43nlfpb9k2zl3q7s4kzhf0lml4wqwaf";
       };

       buildInputs = [ mock nose ];
       propagatedBuildInputs = [ cssselect cssutils lxml requests ];

       meta = {
         description = "Turns CSS blocks into style attributes ";
         homepage = https://github.com/peterbe/premailer;
         license = lib.licenses.bsd3;
       };
     };

    psd-tools = buildPythonPackage rec {
       pname = "psd-tools";
       name = "${pname}-${version}";
       version = "1.4";

       src = fetchPypi {
         inherit pname version;
         sha256 = "0g2vss5hwlk96w0yj42n7ia56mly51n92f2rlbrifhn8hfbxd38s";
       };

       propagatedBuildInputs = [ docopt pillow ];

       meta = {
         description = "Python package for reading Adobe Photoshop PSD files";
         homepage = https://github.com/kmike/psd-tools;
         license = lib.licenses.mit;
       };
     };

    pycryptodomex = buildPythonPackage rec {
       pname = "pycryptodomex";
       name = "${pname}-${version}";
       version = "3.4.5";

       src = fetchPypi {
         inherit pname version;
         sha256 = "1n5w5ls5syapmb39kavqgz2sa9pinzx4c9dvwa2147gj0hkh87wj";
       };

       meta = {
         description = "A self-contained cryptographic library for Python";
         homepage = https://www.pycryptodome.org;
         license = lib.licenses.bsd2;
       };
     };
  pyjwkest = buildPythonPackage rec {
       pname = "pyjwkest";
       name = "${pname}-${version}";
       version = "1.3.2";

       src = fetchPypi {
         inherit pname version;
         sha256 = "11rrswsmma3wzi2qnmq929323yc6i9fkjsv8zr7b3vajd72yr49d";
       };

       buildInputs = [ pytest ];
       propagatedBuildInputs = [ future pycryptodomex requests six ];

       meta = {
         description = "Implementation of JWT, JWS, JWE and JWK";
         homepage = https://github.com/rohe/pyjwkest;
         license = lib.licenses.asl20;
       };
     };

    sampledata = buildPythonPackage rec {
       pname = "sampledata";
       name = "${pname}-${version}";
       version = "0.3.7";

       src = fetchPypi {
         inherit pname version;
         sha256 = "1kx2j49lag30d32zhzsr50gl5b949wa4lcdap2filg0d07picsdh";
       };

       buildInputs = [ nose versiontools ];
       propagatedBuildInputs = [ pytz six ];

     # ERROR: test_image_path_from_directory (tests.tests.TestImageHelpers)
     # ERROR: test_image_stream (tests.tests.TestImageHelpers)
       doCheck = false;

       checkPhase = ''
         nosetests -e "TestImageHelpers"
       '';

       meta = {
         description = "Sample Data generator for Python ";
         homepage = https://github.com/jespino/sampledata;
         license = lib.licenses.bsd3;
       };
     };

 serpy = buildPythonPackage rec {
       pname = "serpy";
       name = "${pname}-${version}";
       version = "0.1.1";

       src = fetchPypi {
         inherit pname version;
         sha256 = "0r9wn99x9nbqxfancnq9jh3cn83i1b6gc79xj0ipnxixp661yj5i";
       };

       # ImportError: No module named 'tests
       doCheck = false;

       buildInputs = [ flake8 py pyflakes tox ];
       propagatedBuildInputs = [ six ];

       meta = {
         description = "ridiculously fast object serialization";
         homepage = https://github.com/clarkduvall/serpy;
         license = lib.licenses.mit;
       };
     };
   };

  python = pkgs.python3;
  penv = with pkgs.python3Packages; with myPythonPackages;  python.buildEnv.override {
    extraLibs = [
      taiga-back
      pkgs.python3Packages.gunicorn
      pkgs.python3Packages.gevent
      pkgs.python3Packages.celery
      pkgs.python3Packages.django
    ] ++  [
    amqp
    asana
    bleach
    cairosvg
    celery
    cryptography
    cssutils
    dateutil
    diff-match-patch
    django
    (django-ipware.override { django = django; })
    (django-jinja.override { django = django; })
    (django-pglocks.override { django = django; })
    django-picklefield
    (django-sampledatahelper.override { django = django; })
    (django-sites.override { django = django; })
    (django-sr.override { django = django; })
    (djmail.override { django = django; })
    (easy-thumbnails.override { django = django; })
    fn
    gunicorn
    html5lib
    jinja2
    lxml
    markdown
    netaddr
    pillow
    premailer
    psd-tools
    psycopg2
    pygments
    pyjwkest
    pyjwt
    python_magic
    pytz
    raven
    redis
    requests
    requests_oauthlib
    serpy
    six
    unidecode
    webcolors
    ];
  };

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
    buildCommand = ''
      mkdir -p $out/settings
      ln -s ${taiga-back}/${python.sitePackages}/settings/*.py $out/settings/
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
      default = true;
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

    in if type == "postgresql" then ''
      export PYTHONPATH="${taigaBackConfigPkg}:${penv}/${python.sitePackages}/"
      # code opens ("taiga/hooks/bitbucket/migrations/logo.png") for setting up the database
      cd ${taiga-back}/${python.sitePackages}
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

    users.taigaio-events = {
      description = "taigaio-events server user";
      group       = "taigaio-events";
    };
    groups.taigaio-events = {};

    systemd.services.taiga-back = rec {
     description = "${config.uniqueName} main service (taigaio)";

      wantedBy      = [ "multi-user.target" ];
      after         = [ "network.target" ];

      environment = {
        # using the first line below it finds taiga while using the second it doesn't. however, taiga-back from penv should already bring these dependencies...
        PYTHONPATH = lib.traceVal "${taigaBackConfigPkg}:${penv}/${python.sitePackages}/:${taiga-back}/${python.sitePackages}"; #:${pkgs.python3Packages.celery}/${python.sitePackages}:/nix/store/xw9ncz3hf7wrqzwj9kj6k22vlfmxydry-python3-3.6.5/lib/python3.6"; #:${penv}/${python.sitePackages}/celery";
        #PYTHONPATH = "${taigaBackConfigPkg}:${penv}/${python.sitePackages}/";
      };

      serviceConfig = {
        User = mkUniqueUser "taigaio";
        Group = mkUniqueGroup "taigaio";
        #WorkingDirectory = "${config.stateDir}/www";
        WorkingDirectory = "${taiga-back}";
        PrivateTmp = false;
        # FIXME: port 8000 is hardcoded
        ExecStart = 
         if config.enableWsgi then ''
	        ${pkgs.python3Packages.gunicorn}/bin/gunicorn taiga.wsgi \
            -k gevent \
            -u ${mkUniqueUser "taigaio"} \
            -g ${mkUniqueGroup "taigaio"} \
            --name gunicorn-taiga \
            --pythonpath=${environment.PYTHONPATH} \
            --log-level ${if config.enableDebug then "debug" else "info"} \
            --workers ${toString config.wsgiWorkers} \
            --pid ${config.stateDir}/www/gunicorn-taiga.pid \
            --bind 127.0.0.1:8000
        '' else 
        ''
          ${taiga-back}/bin/manage.py runserver --nostatic "127.0.0.1:8000"
        '';
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
        User = mkUniqueUser "taigaio-events";
        Group = mkUniqueGroup "taigaio-events";
        
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
      port = 8888;
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
