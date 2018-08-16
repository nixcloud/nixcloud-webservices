{ stdenv, fetchFromGitHub, pkgs, python3Packages, lib }:
with lib;
let
    #    pythong3Packages = python3Packages // myPythonPackages;
    myPythonPackages = with python3Packages; rec {
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
    
       # django.core.exceptions.ImproperlyConfigured: Requested setting IPWARE_TRUSTED_PROXY_LIST, but settings are not configured. You must either define the environment variable DJANGO_SETTINGS_MODULE or call settings.configure() before accessing settings.
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
    
       # python installed: The directory '/homeless-shelter/.cache/pip/http' or its parent directory is not owned by the current user and the cache has been disabled. Please check the permissions and owner of that directory. If executing pip with sudo, you may want 
       #sudo's -H flag.,appdirs==1.4.3,Django==1.11.1,django-jinja==2.2.2,Jinja2==2.9.6,MarkupSafe==1.0,packaging==16.8,pyparsing==2.2.0,pytz==2017.2,six==1.10.0
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
    
       # django.core.exceptions.ImproperlyConfigured: Requested settings, but settings are not configured. You must either define the environment variable DJANGO_SETTINGS_MODULE or call settings.configure() before accessing settings.
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
    
       # django.core.exceptions.ImproperlyConfigured: Requested setting DEFAULT_INDEX_TABLESPACE, but settings are not configured. You must either define the environment variable DJANGO_SETTINGS_MODULE or call settings.configure() before accessing settings.
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
in
python3Packages.buildPythonApplication rec {
  pname = "taiga-back";
  version = "3.3.13";
  #version = "3.3.14";
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "taigaio";
    repo = "taiga-back";
    rev = "${version}";
    sha256 = "1cy5ak7mw9ia9b0d1lil0s6ck87kinrmicsw61m6vpkal1slnnf7";  # 3.3.13
    #sha256 = "1csampq2g84za3fxnlfr9sffq304mz5mj9000dyk4y0720w9v1d1"; # 3.3.14
  };
  
  propagatedBuildInputs = with python3Packages; with myPythonPackages; [
    pkgs.gettext
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

  patches = [
    ./taiga-back-setup-py.patch
  ];

  postPatch = ''
    sed -i 's/html5lib.serializer.htmlserializer/html5lib.serializer/' taiga/mdrender/service.py
  '';

  postFixup = ''
    wrapPythonProgramsIn $out/bin/manage.py
    #HACK wrapper breaks django manage.py
    sed -i "$out/bin/.manage.py-wrapped" -e '
      0,/sys.argv\[0\].*;/s/sys.argv\[0\][^;]*;//
    '
  '';

  meta = {
    description = "Project management web application with scrum in mind! Built on top of Django and AngularJS (Backend Code)";
    inherit (src.meta) homepage;
    license = stdenv.lib.licenses.agpl3;
  };
}
