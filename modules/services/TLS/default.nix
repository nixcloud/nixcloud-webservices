{ config, pkgs, lib, ... } @ toplevel:
with lib;

let
  cfg = config.nixcloud.TLS;
  stateDir = "/var/lib/nixcloud/TLS";

  selfSignedCertScript = identifier: subjectAltName: workDir: pkgs.writeScriptBin "selfSignedCertScript.sh" ''
    mkdir /tmp/selfsigned
    # RANDFILE needs to be defined, otherwise `openssl` attempts to write to `~/.rnd`
    # which will fail when everything else is write-protected
    export RANDFILE=/tmp/rnd

    # Create self-signed key
    workdir=/tmp
    echo "Create a self signed CA 1/2"
    ${pkgs.openssl.bin}/bin/openssl genrsa -des3 -passout pass:x -out $workdir/server.pass.key 2048
    echo "Create a self signed CA 2/2"
    ${pkgs.openssl.bin}/bin/openssl rsa -passin pass:x -in $workdir/server.pass.key -out $workdir/server.key
    echo "Create a CSR"
    ${pkgs.openssl.bin}/bin/openssl req -new -key $workdir/server.key -out $workdir/server.csr -subj "/C=DE/ST=Burrow/L=Linux/O=OrgName/OU=nixcloud IT Department"

    echo "Sign the CSR"
    ${pkgs.openssl.bin}/bin/openssl x509 -req -extfile <(printf "subjectAltName=${subjectAltName}") -days 1 -in $workdir/server.csr -signkey $workdir/server.key -out $workdir/server.crt
    echo "Done creating a self signed certificate"
  '';

  # to prevent accidentally exceeding the ACME's rate limit (API) we hash the options in a way
  # that the order of the 'inputs' as domains, extraDomains and API endpoint don't affect the
  # generated certificate
  hashIdentifierACMEOptions = identifier: let 
    c = config.nixcloud.TLS.certs.${identifier};
    server = c.acmeApiEndpoint;
    h = fold (el: c: c // { ${el} = ""; }) {} ([ c.domain ] ++ c.extraDomains ++ [ server ]);
  in
    builtins.hashString "sha256" (builtins.toJSON h);

  # Create a unique name for a user, creating a hashed version of it
  # whenever the length exceeds 31 characters. The reason for that is that
  # glibc imposes a restriction of maximum 31 characters on user and group
  # names.
  mkUniqueUserGroup = prefix: suffix: let
    uniqueHash = builtins.hashString "sha256" suffix;
    hashLen = 30 - lib.stringLength prefix;
    hashed = "${prefix}-${builtins.substring 0 hashLen uniqueHash}";
  in if builtins.stringLength suffix > 31 then hashed else suffix;

  replace = [ "." ];
  replaceWith = [ "-" ];
  filterIdentifier = x: mkUniqueUserGroup "cert" (replaceChars replace replaceWith x);

  nixcloudTLSDomainType = mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.domain";
    check = x: (isString x && x != "")
      || isNull x;
    merge = mergeEqualOption;
  };
  nixcloudTLSEmailType = mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.email";
    check = x: (isString x && x != "");
    merge = mergeEqualOption;
  };
  nixcloudTLSModeType = mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.mode";
    merge = mergeEqualOption;
    check = x: ((isString x && x == "ACME")
        || (isString x && x == "selfsigned")
        || ((isAttrs x || isFunction x) && x ? tls_certificate_key && x ? tls_certificate));
  };

  c = x: isList x && fold (el: c: if (isString el) then c else false) true x;
  m = loc: defs: unique (fold (el: c: el.value ++ c) [] defs);

  nixcloudUsersType = mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.users";
    check = c;
    merge = m;
  };
  acmeApiEndpointType = mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.acmeApiEndpoint";
    check = x: (isString x && x != "");
    merge = mergeEqualOption;
  };

  nixcloudExtraDomainsType = mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.extraDomains";
    check = c;
    merge = m;
  };
  nixcloudReloadType = mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.reload";
    check = c;
    merge = m;
  };
  nixcloudRestartType = mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.restart";
    check = c;
    merge = m;
  };

  certOpts = { name, ... } @ toplevel: let identifier = name; in {
    options = {
      domain = mkOption {
        type = nixcloudTLSDomainType;
        default = identifier;
        description = ''
          Domain to fetch certificate for (defaults to the entry name)
        '';
      };
      acmeApiEndpoint = mkOption {
        default = "https://acme-v02.api.letsencrypt.org/directory";
        example = "https://acme-staging-v02.api.letsencrypt.org/directory";
        type = acmeApiEndpointType;
        description = ''
          ACME with let's encrypt has a production and a testing endpoint. This option can be set per identifier.

          See https://letsencrypt.org/docs/staging-environment/
        ''; #'
      };
      extraDomains = mkOption {
        type = nixcloudExtraDomainsType;
        default = [];
        example = literalExample ''
          [ "example.org" "mydomain.org" ]
        '';
        apply = x: unique x;
        description = ''
          A list of extra domain names, which are included in the one
          certificate to be issued.
        '';
      };
      reload = mkOption {
        type = nixcloudReloadType;
        apply = x: lib.subtractLists toplevel.config.restart (unique x);
        default = [];
        example = [ "postfix.service" ];
        description = ''
          A list of systemd services which are <emphasis>reloaded</emphasis>
          after certificates are re-issued. A service is only
          <emphasis>reloaded</emphasis> once, even when mentioned several
          times in this list. It is not reloaded if it is also listed in the
          <option>restart</option> list, then it is only restarted. For most
          services it is sufficient to <option>reload</option> them rather to <option>restart</option> them.
        '';
      };
      restart = mkOption {
        type = nixcloudRestartType;
        default = [];
        apply = x: unique x;
        example = [ "postfix.service" ];
        description = ''
          A list of systemd services which are <emphasis>restarted</emphasis>
          after certificates are re-issued. A service is only
          <emphasis>restarted</emphasis> once, even when mentioned serveral
          times in this list.
        '';
      };
      email = mkOption {
        type = nixcloudTLSEmailType;
        description = ''
          Optional contact email address used for ACME requests or self-signed certificates. 
          Since ACME requires this option to be set our default is: "info@''${domain}".
        '';
      };
      users = mkOption {
        type = nixcloudUsersType;
        default = [];
        example = [ "murmur" "radicale" ];
        description = ''
          By default the certificates can only be read by the 'root' user and 'root' group. Using the 'users' option, one can make a certificate available to one or several other users. This is especially interesting for users listed in https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/misc/ids.nix, can be added so they have access to read the certificates.

          Internally we create a group per "identifier" and add all the specified users to this group.
        '';
      };
      mode = mkOption {
        type = nixcloudTLSModeType;
        default = "ACME";
        description = ''
          Use this option to set the <emphasis>TLS mode</emphasis> to be used:

          <variablelist>
            <varlistentry>
              <term><literal>ACME</literal></term>
              <listitem><para>
                uses let's encrypt to automatically download and install TLS
                certificates (default)
              </para></listitem>
            </varlistentry>
            <varlistentry>
              <term><literal>selfsigned</literal></term>
              <listitem><para>
                will create self-signed certificates
              </para></listitem>
            </varlistentry>
            <varlistentry>
              <term><programlisting>
                { tls_certificate_key = /flux/to/cert.pem;
                  tls_certificate = /flux/to/key.pem;
                }
              </programlisting></term>
              <listitem><para>
                user-supplied certificates
              </para></listitem>
            </varlistentry>
          </variablelist>

          <note><para>
            Certificates are copied into
            <filename class="directory">${stateDir}</filename> and
            are referenced from there since we might introduce differentiated
            user/group permissions on certificates and that won't work with the
            certificate is located in
            <filename class="directory">/root</filename> or some other place
            not managed by <option>nixcloud.TLS</option>.
          </para></note>
        ''; #'
      };
      tls_certificate_key = mkOption {
        type = types.path;
        readOnly = true;
        default =
          if isString toplevel.config.mode then
            if toplevel.config.mode == "ACME" then "${stateDir}/${identifier}/acmeSupplied/${hashIdentifierACMEOptions identifier}/certificates/${config.nixcloud.TLS.certs.${identifier}.domain}.key" else
            if toplevel.config.mode == "selfsigned" then "${stateDir}/${identifier}/selfsigned/key.pem" else
            "/undefined1"
          else if isAttrs toplevel.config.mode then "${stateDir}/${identifier}/userSupplied/key.pem" else
            "/undefined2";
        description = ''
          Internally set option (read only) which points to the
          <filename>key.pem</filename> file, depending on the
          <option>nixcloud.TLS.certs.&lt;name&gt;.mode</option> setting.
        '';
      };
      tls_certificate = mkOption {
        type = types.path;
        readOnly = true;
        default =
          if isString toplevel.config.mode then
            if toplevel.config.mode == "ACME" then "${stateDir}/${identifier}/acmeSupplied/${hashIdentifierACMEOptions identifier}/certificates/${config.nixcloud.TLS.certs.${identifier}.domain}.crt" else
            if toplevel.config.mode == "selfsigned" then "${stateDir}/${identifier}/selfsigned/fullchain.pem" else
            "/undefined1_"
          else if isAttrs toplevel.config.mode then "${stateDir}/${identifier}/userSupplied/fullchain.pem" else
            "/undefined2_";
        description = ''
          Internally set option (read only) which points to the
          <filename>fullchain.pem</filename> file, depending on the
          <option>nixcloud.TLS.certs.&lt;name&gt;.mode</option> setting.
        '';
      };
    };
  };
in

{
  options.nixcloud.TLS = {
    email = mkOption {
      type = types.str;
      description = ''
        Optional (global) contact email address used for ACME requests or self-signed certificates. 
        This global option can be overriden using the email option in the `certs` scope.
      '';
    };
    certs = mkOption {
      default = {};
      type = types.attrsOf (types.submodule ({ pkgs, lib, config, options } @ lowlevel: {
        imports = [ certOpts ];
        config = {
          email = lib.mkDefault (if (toplevel.options.nixcloud.TLS.email.isDefined) then toplevel.config.nixcloud.TLS.email else "info@${lowlevel.config.domain}");
        };
      }));
      description = ''
        Attribute set of certificates to be used by various NixOS services.
      '';
      example = literalExample ''
        "example.com" = {
          email = "foo@example.com";
          reload = [ "postfix.service" "myservice.service" ];
        };
      '';
    };
  };
  config = let
    acmeSupplied = fold (identifier: con: con ++ [
      (nameValuePair "nixcloud.TLS-acmeSupplied-${identifier}" (let
        c = config.nixcloud.TLS.certs.${identifier};
        allDomains = concatMapStringsSep " " (x: "--domains=\"${x}\"") (unique ( [ c.domain ] ++ c.extraDomains));
        hash = hashIdentifierACMEOptions identifier;
        path = "${stateDir}/${identifier}/acmeSupplied/${hash}";
      in {
        description = "nixcloud.TLS: create acmeSupplied certificate for ${identifier}";
        preStart = ''
          mkdir -p ${stateDir}/${identifier}/acmeSupplied/${hash}/certificates
          chmod 0750 ${stateDir}/${identifier}/acmeSupplied -R
          chown nixcloud-lego-user:${filterIdentifier identifier} ${stateDir}/${identifier} -R
        '';
        # https://github.com/xenolf/lego/issues/693
        script = ''
          cd ${stateDir}/${identifier}/acmeSupplied
          echo "lego certificate renewal check"
          set +e
          ${pkgs.lego}/bin/lego ${allDomains} --email="${c.email}" --exclude="dns-01" --exclude="tls-alpn-01" --webroot="/run/nixcloud/lego/${identifier}/challenges" --path="${path}" --accept-tos --server="${c.acmeApiEndpoint}" renew --days=15
          status=$?
          echo "return code was $status"
          set -e

          if [ "$status" != "0" ]; then
              echo "initial lego certificate query"
              ${pkgs.lego}/bin/lego ${allDomains} --email="${c.email}" --exclude="dns-01" --exclude="tls-alpn-01" --webroot="/run/nixcloud/lego/${identifier}/challenges" --path="${path}" --accept-tos --server="${c.acmeApiEndpoint}" run
          fi
        '';
        postStart = ''
          chown root:${filterIdentifier identifier} ${stateDir}/${identifier} -R
          chmod 0750 ${stateDir}/${identifier}/acmeSupplied -R
          ${lib.concatStringsSep "\n" (map (el: "  systemctl --no-block restart ${el}") c.restart)}
          ${lib.concatStringsSep "\n" (map (el: "  systemctl --no-block reload ${el}") c.reload)}
        '';
        serviceConfig = {
          User = "nixcloud-lego-user";
          ReadWritePaths = "-${stateDir}/${identifier}/acmeSupplied";
          SupplementaryGroups = "${filterIdentifier identifier}";
          ProtectSystem = "strict";
          PermissionsStartOnly = true;
          Type = "oneshot";
          RuntimeDirectory = "nixcloud/lego/${identifier}/challenges";
        };
        requires = [ "nixcloud.TLS-acmeSuppliedPreliminary-${identifier}.service" "nixcloud.reverse-proxy.service" ];
        after = [ "nixcloud.TLS-acmeSuppliedPreliminary-${identifier}.service" "nixcloud.reverse-proxy.service" ];
        before = [ "nixcloud.TLS-acmeSupplied-certificates.target" ];
        wantedBy = [ "nixcloud.TLS-acmeSupplied-certificates.target" ];
      }))
    ]) [] (filter (x: (config.nixcloud.TLS.certs.${x}.mode == "ACME")) (attrNames config.nixcloud.TLS.certs));

    acmeSuppliedPreliminary = fold (identifier: con: con ++ [
      (nameValuePair "nixcloud.TLS-acmeSuppliedPreliminary-${identifier}" (let
        c = config.nixcloud.TLS.certs.${identifier};
        allDomains = concatMapStringsSep " " (x: "--domains=${x}") ( [ c.domain ] ++ c.extraDomains);
        hash = hashIdentifierACMEOptions identifier;
        workDir = "/tmp";
        targetPath = "${stateDir}/${identifier}/acmeSupplied/${hash}/certificates/";
        tls_certificate_path = "${targetPath}/${identifier}.crt";
        tls_certificate_key_path = "${targetPath}/${identifier}.key";
      in {
        description = "nixcloud.TLS: create acmeSuppliedPreliminary certificate for ${identifier}";
        preStart = ''
          mkdir -p ${stateDir}/${identifier}/acmeSupplied/${hash}/certificates
          chmod 0750 ${stateDir}/${identifier}/acmeSupplied -R
          chown nixcloud-lego-user:${filterIdentifier identifier} ${stateDir}/${identifier} -R
        '';
        script =
          let
            subjectAltName = concatMapStringsSep "," (x: "DNS:${x}") ([ config.nixcloud.TLS.certs.${identifier}.domain ] ++ config.nixcloud.TLS.certs.${identifier}.extraDomains);
          in ''
            ${selfSignedCertScript identifier subjectAltName workDir}/bin/selfSignedCertScript.sh
          '';
        postStart = ''
          # ideally, the whole service shouldn't have to run in case the key and certificate are already in place, but:
          # systemd doesn't allow to combine the logic of `ConditionFileNotEmpty=` as boolean OR, but only as AND
          # so this problem needs to be solved in-script by simply creating both of them in their temporary location
          # everytime and using `cp -n` to only copy files, which aren't present yet
          # Before that, make sure that either both are there or both are absent, but remove the remaining one if just
          # one of both is there
          [[ ! -e "${tls_certificate_key_path}" || ! -e "${tls_certificate_path}" ]] \
            && echo "Only one of key/cert found, removing remaining one" \
            && rm -f "${tls_certificate_key_path}" "${tls_certificate_path}"
          cp -n ${workDir}/server.key ${toString tls_certificate_key_path}
          cp -n ${workDir}/server.crt ${toString tls_certificate_path}
          chown root:${filterIdentifier identifier} ${stateDir}/${identifier} -R
          chmod 0750 ${stateDir}/${identifier}/acmeSupplied -R
        '';
        serviceConfig = {
          User="nixcloud-lego-user";
          ReadWritePaths = "-${stateDir} -${stateDir}/${identifier} -${stateDir}/${identifier}/selfsigned";
          SupplementaryGroups = "${filterIdentifier identifier}";
          ProtectSystem="strict";
          PermissionsStartOnly = true;
          Type = "oneshot";
          RuntimeDirectory = "nixcloud/lego/${identifier}/challenges";
          PrivateTmp = true;
        };
        before = [ "nixcloud.TLS-reverse-proxy-certificates.target" ];
        wantedBy = [ "nixcloud.TLS-reverse-proxy-certificates.target" ];
      }))
    ]) [] (filter (x: (config.nixcloud.TLS.certs.${x}.mode == "ACME")) (attrNames config.nixcloud.TLS.certs));

    userSuppliedTargets = fold (identifier: con: if isAttrs config.nixcloud.TLS.certs.${identifier}.mode then con ++ [
      (nameValuePair "nixcloud.TLS-userSupplied-${identifier}" (let
        c = config.nixcloud.TLS.certs.${identifier};
        tls_certificate =     c.mode.tls_certificate;
        tls_certificate_key = c.mode.tls_certificate_key;
      in {
        description = "nixcloud.TLS: create userSupplied certificate for ${identifier}";

        script = ''
          rm -Rf ${stateDir}/${identifier}/userSupplied
          TMPDIR=$(mktemp -d userSupplied-${identifier}.XXXXXXXXXX --tmpdir)
          mkdir $TMPDIR/userSupplied

          cp ${toString tls_certificate_key} $TMPDIR/userSupplied/key.pem
          cp ${toString tls_certificate} $TMPDIR/userSupplied/fullchain.pem

          chmod 0700 $TMPDIR/userSupplied
          mkdir -p ${stateDir}/${identifier}/
          chmod 0755 ${stateDir}
          mv $TMPDIR/userSupplied ${stateDir}/${identifier}/
          chmod 0550 ${stateDir}/${identifier} -R
          chown :${filterIdentifier identifier} ${stateDir}/${identifier} -R
        '';
        preStart = ''
          mkdir -p ${stateDir}/${identifier}/
          chmod 0550 ${stateDir}/${identifier} -R
          chown :${filterIdentifier identifier} ${stateDir}/${identifier} -R
        '';
        serviceConfig = {
          Type = "oneshot";
          RuntimeDirectory = "nixcloud.TLS-acme-userSupplied-${identifier}";
        };
        before = [ "nixcloud.TLS-userSupplied-certificates.target" ];
        wantedBy = [ "nixcloud.TLS-userSupplied-certificates.target" ];
      }))
    ] else con) [] (attrNames config.nixcloud.TLS.certs);

    selfsignedTargets = fold (identifier: con: con ++ [
      (nameValuePair "nixcloud.TLS-selfsigned-${identifier}" (let
        c = config.nixcloud.TLS.certs.${identifier};
        workDir = "/tmp";
        targetPath = "${stateDir}/${identifier}/selfsigned/";
        tls_certificate_path = "${targetPath}/fullchain.pem";
        tls_certificate_key_path = "${targetPath}/key.pem";
      in {
        description = "nixcloud.TLS: create self-signed certificate for ${identifier}";

        preStart = ''
          mkdir -p ${targetPath}
          chmod 0550 -R ${targetPath}
          chown :${filterIdentifier identifier} ${targetPath} -R
        '';
        script = let
          subjectAltName = concatMapStringsSep "," (x: "DNS:${x}") ([ config.nixcloud.TLS.certs.${identifier}.domain ] ++ config.nixcloud.TLS.certs.${identifier}.extraDomains);
        in ''
          ${selfSignedCertScript identifier subjectAltName workDir}/bin/selfSignedCertScript.sh
          cp -n ${workDir}/server.key ${toString tls_certificate_key_path}
          cp -n ${workDir}/server.crt ${toString tls_certificate_path}
        '';
        postStart = ''
          chown root:${filterIdentifier identifier} ${targetPath} -R
          chmod 0750 ${targetPath} -R
        '';
        serviceConfig = {
          Type = "oneshot";
          ReadWritePaths = "-${stateDir} -${stateDir}/${identifier} -${stateDir}/${identifier}/selfsigned";
          ProtectSystem="strict";
          PermissionsStartOnly = true;
          PrivateTmp = true;
        };
        unitConfig = {
          # Do not create self-signed key when key already exists
          ConditionPathExists = "!${stateDir}/${identifier}/selfsigned";
        };
        before = [ "nixcloud.TLS-selfsigned-certificates.target" ];
        wantedBy = [ "nixcloud.TLS-selfsigned-certificates.target" ];
      }))
    ]) [] (filter (x: (config.nixcloud.TLS.certs.${x}.mode == "selfsigned")) (attrNames config.nixcloud.TLS.certs));
  in {

    assertions = let
      allExtraDomains = fold (el: c: c ++ config.nixcloud.TLS.certs.${el}.extraDomains) [] (attrNames config.nixcloud.TLS.certs);
    in [
      { assertion = (length allExtraDomains == length (unique allExtraDomains));
        message = "nixcloud.TLS: Detected duplicate use of a domain in at least two different nixcloud.TLS.certs.<identifier>.extraDomains lists!";
      }
    ];

    users.groups = fold (identifier: con: con // {
      "${filterIdentifier identifier}" = let c = config.nixcloud.TLS.certs.${identifier}; in { members = c.users; };
    }) {} (attrNames config.nixcloud.TLS.certs);

    users.users = optionalAttrs (acmeSupplied != []) {
      nixcloud-lego-user = {};
    };

    systemd.services = listToAttrs (selfsignedTargets ++ userSuppliedTargets ++ acmeSupplied ++ acmeSuppliedPreliminary);

    systemd.timers = fold (identifier: con: con // {
      "nixcloud.TLS-acmeSupplied-${identifier}" =
      {
        description = "Renew ACME Certificate for ${identifier}";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "daily";
          Unit = "nixcloud.TLS-acmeSupplied-${identifier}.service";
          Persistent = "yes";
          AccuracySec = "5m";
          RandomizedDelaySec = "1h";
        };
      };
    }) {} (filter (x: (config.nixcloud.TLS.certs.${x}.mode == "ACME")) (attrNames config.nixcloud.TLS.certs));

    systemd.targets."nixcloud.TLS-acmeSuppliedPreliminary-certificates" = {
      description = "If reached, all preliminary ACME certificates, are in place";
    };

    systemd.targets."nixcloud.TLS-acmeSupplied-certificates" = {
      description = "If reached, all certificates, which were supplied (or were supposed to be supplied) by lego, are in place";
    };

    systemd.targets."nixcloud.TLS-userSupplied-certificates" = {
      description = "If reached, all certificates, which were supplied by the user, were already copied in place to be used";
    };

    systemd.targets."nixcloud.TLS-selfsigned-certificates" = {
      description = "If reached, all self-signed certificates, which were automatically created, were already copied in place to be used";
    };
 
    # only used for the nixcloud.reverse-proxy
    systemd.targets."nixcloud.TLS-reverse-proxy-certificates" = {
      description = "If reached, all certificates managed via nixcloud.TLS have been put into place to be used";

      wantedBy = [ "multi-user.target" ];

      after =
           [ "nixcloud.TLS-userSupplied-certificates.target" ]
        ++ [ "nixcloud.TLS-acmeSuppliedPreliminary-certificates.target" ]
        ++ [ "nixcloud.TLS-selfsigned-certificates.target" ];

      wants =
           [ "nixcloud.TLS-userSupplied-certificates.target" ]
        ++ [ "nixcloud.TLS-acmeSuppliedPreliminary-certificates.target" ]
        ++ [ "nixcloud.TLS-selfsigned-certificates.target" ];
    };

    systemd.targets."nixcloud.TLS-certificates" = {
      description = "If reached, all certificates managed via nixcloud.TLS have been put into place to be used";

      wantedBy = [ "multi-user.target" ];

      after =
           [ "nixcloud.TLS-acmeSupplied-certificates.target" ]
        ++ [ "nixcloud.TLS-userSupplied-certificates.target" ]
        ++ [ "nixcloud.TLS-selfsigned-certificates.target" ];

      wants =
           [ "nixcloud.TLS-acmeSupplied-certificates.target" ]
        ++ [ "nixcloud.TLS-userSupplied-certificates.target" ]
        ++ [ "nixcloud.TLS-selfsigned-certificates.target" ];
    };

    nixcloud.tests.wanted = [ ./test.nix ];

    meta = {
      maintainers = with lib.maintainers; [ qknight ];
    };
  };
}
