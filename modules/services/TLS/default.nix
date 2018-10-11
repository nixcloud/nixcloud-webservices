{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.nixcloud.TLS;
  stateDir = "/var/lib/nixcloud/TLS";

  # to prevent accidently exceeding the ACME's rate limit (API) we hash the options in a way
  # that the order of the 'inputs' as domains, extraDomains and API endpoint don't affect the
  # generated certificate
  hashIdentifierACMEOptions = identifier: let 
    c = config.nixcloud.TLS.certs.${identifier};
    server = c.acmeApiEndpoint;
    h = fold (el: c: c // { ${el} = ""; }) {} ([ c.domain ] ++ c.extraDomains ++ [ server ]);
  in
    builtins.hashString "sha256" (builtins.toJSON h);

  replace = [ "." ];
  replaceWith = [ "-" ];
  filterIdentifier = x: "nc-${replaceChars replace replaceWith x}";

  nixcloudTLSDomainType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.domain";
    check = x: (isString x && x != "")
      || isNull x;
    merge = mergeEqualOption;
  };
  nixcloudTLSEmailType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.email";
    check = x: (isString x && x != "")
      || isNull x;
    merge = mergeEqualOption;
  };
  nixcloudTLSModeType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.mode";
    merge = mergeEqualOption;
    check = x: ((isString x && x == "ACME")
        || (isString x && x == "selfsigned")
        || ((isAttrs x || isFunction x) && x ? tls_certificate_key && x ? tls_certificate));
  };

  c = x: isList x && fold (el: c: if (isString el) then c else false) true x;
  m = loc: defs: unique (fold (el: c: el.value ++ c) [] defs);

  nixcloudUsersType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.users";
    check = c;
    merge = m;
  };
  acmeApiEndpointType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.acmeApiEndpoint";
    check = x: (isString x && x != "");
    merge = mergeEqualOption;
  };

  nixcloudExtraDomainsType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.extraDomains";
    check = c;
    merge = m;
  };
  nixcloudReloadType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.reload";
    check = c;
    merge = m;
  };
  nixcloudRestartType = mkOptionType {
    name = "nixcloud.TLS.certs.<name>.restart";
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
        default = "https://acme-staging-v02.api.letsencrypt.org/directory";
        # FIXME: revert this to the 'none' staging
        #default = "https://acme-v02.api.letsencrypt.org/directory";
        example = "https://acme-staging-v02.api.letsencrypt.org/directory";
        type = acmeApiEndpointType;
        description = ''
          ACME with let's encrypt has a production and a testing endpoint. This option can be set per identifier.
        '';
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
          <option>restart</option> list, then it is only restarted.
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
        default = null;
        description = ''
          Optional contact email address for the let's encrypt CA to be able to
          reach you when using ACME.
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
          else if isAttrs toplevel.config.mode then "${stateDir}/${identifier}/userupplied/fullchain.pem" else
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
      type = types.nullOr types.str;
      default = null;
      description = ''
        Optional (global) contact email address used for all let's encrypt CA requests so they can
        reach you. This global option can be overriden using the email option in the `certs` scope.
      '';
    };
    certs = mkOption {
      default = {};
      type = types.attrsOf (types.submodule ({ name, pkgs, lib, ... } @ ppp: {
        imports = [ certOpts ];
        config = {
          email = lib.mkDefault config.nixcloud.TLS.email; #ppp.email;
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
    acmeSupplied = fold (identifier: con: if (config.nixcloud.TLS.certs.${identifier}.mode) == "ACME" then con ++ [
      (nameValuePair "nixcloud.TLS-acmeSupplied-${identifier}" (let
        c = config.nixcloud.TLS.certs.${identifier};
        allDomains = concatMapStringsSep " " (x: "--domains=${x}") ( [ c.domain ] ++ c.extraDomains);
        email = if (isString c.email) then c.email else "info@${c.domain}";
        hash = hashIdentifierACMEOptions identifier;
      in {
        description = "nixcloud.TLS: create acmeSupplied certificate for ${identifier}";
        preStart = ''
          mkdir -p ${stateDir}/${identifier}/acmeSupplied/${hash}/certificates
          chmod 0750 ${stateDir}/${identifier}/acmeSupplied -R
          chown nixcloud-lego-user:${filterIdentifier identifier} ${stateDir}/${identifier} -R
        '';
        script = ''
          cd ${stateDir}/${identifier}/acmeSupplied
          ${pkgs.nixcloud.lego}/bin/lego ${allDomains} --email=${email} --exclude=dns-01 --exclude=tls-alpn-01 --webroot=/run/nixcloud/lego/${identifier}/challenges --path=${stateDir}/${identifier}/acmeSupplied/${hash} --accept-tos --server=${c.acmeApiEndpoint} run
          ${pkgs.nixcloud.lego}/bin/lego ${allDomains} --email=${email} --exclude=dns-01 --exclude=tls-alpn-01 --webroot=/run/nixcloud/lego/${identifier}/challenges --path=${stateDir}/${identifier}/acmeSupplied/${hash} --accept-tos --server=${c.acmeApiEndpoint} renew --days 15
        '';
        postStart = ''
          chown root:${filterIdentifier identifier} ${stateDir}/${identifier} -R
          chmod 0750 ${stateDir}/${identifier}/acmeSupplied -R
        '';
        serviceConfig = {
          # with DynamicUser we don't know the UID in the preStart when PermissionsStartOnly so we can't use it, see
          # https://stackoverflow.com/questions/52755860/systemd-with-dynamicuser-uid-unknown
          #DynamicUser = true;
          User="nixcloud-lego-user";
          ReadWritePaths = "-${stateDir}/${identifier}/acmeSupplied";
          SupplementaryGroups = "${filterIdentifier identifier}";
          ProtectSystem="strict";
          PermissionsStartOnly = true;
          Type = "oneshot";
          RuntimeDirectory = "nixcloud/lego/${identifier}/challenges";
        };
        onFailure = [ "" ];
        before = [ "nixcloud.TLS-acmeSupplied-certificates.target" ];
        wantedBy = [ "nixcloud.TLS-acmeSupplied-certificates.target" ];
      }))
    ] else con) [] (attrNames config.nixcloud.TLS.certs);

    userSuppliedTargets = fold (identifier: con: if isAttrs config.nixcloud.TLS.certs.${identifier}.mode then con ++ [
      (nameValuePair "nixcloud.TLS-userSupplied-${identifier}" (let
        c = config.nixcloud.TLS.certs.${identifier};
        tls_certificate =     c.mode.tls_certificate;
        tls_certificate_key = c.mode.tls_certificate_key;
      in {
        description = "nixcloud.TLS: create userSupplied certificate for ${identifier}";

        script = ''
          rm -Rf ${stateDir}/${identifier}/userSupplied # should not be needed
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

    selfsignedTargets = fold (identifier: con: if ((config.nixcloud.TLS.certs.${identifier}.mode) == "selfsigned") then con ++ [
      (nameValuePair "nixcloud.TLS-selfsigned-${identifier}" (let
        c = config.nixcloud.TLS.certs.${identifier};
      in {
        description = "nixcloud.TLS: create fallback self-signed certificate for ${identifier}";

        script = let
          subjectAltName = lib.traceValSeq ( concatMapStringsSep "," (x: "DNS:${x}") ([ config.nixcloud.TLS.certs.${identifier}.domain ] ++ config.nixcloud.TLS.certs.${identifier}.extraDomains));
        in ''
          TMPDIR=$(mktemp -d selfsigned-${identifier}.XXXXXXXXXX --tmpdir)
          mkdir $TMPDIR/selfsigned

          # Create self-signed key
          workdir=$(mktemp -d selfsigned-${identifier}.XXXXXXXXXX --tmpdir)
          # create a self signed CA
          ${pkgs.openssl.bin}/bin/openssl genrsa -des3 -passout pass:x -out $workdir/server.pass.key 2048
          ${pkgs.openssl.bin}/bin/openssl rsa -passin pass:x -in $workdir/server.pass.key -out $workdir/server.key
          # create a CSR
          ${pkgs.openssl.bin}/bin/openssl req -new -key $workdir/server.key -out $workdir/server.csr -subj "/C=DE/ST=Burrow/L=Linux/O=OrgName/OU=nixcloud IT Department"

          # sign the CSR
          ${pkgs.openssl.bin}/bin/openssl x509 -req -extfile <(printf "subjectAltName=${subjectAltName}") -days 1 -in $workdir/server.csr -signkey $workdir/server.key -out $workdir/server.crt

          # Move key to destination
          mv $workdir/server.key $TMPDIR/selfsigned/key.pem
          mv $workdir/server.crt $TMPDIR/selfsigned/fullchain.pem

          chmod 0700 $TMPDIR/selfsigned
          mkdir -p ${stateDir}/${identifier}/
          chmod 0755 ${stateDir}
          mv $TMPDIR/selfsigned ${stateDir}/${identifier}/
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
          RuntimeDirectory = "nixcloud.TLS-acme-selfsigned-${identifier}";
        };
        unitConfig = {
          # Do not create self-signed key when key already exists
          ConditionPathExists = "!${stateDir}/${identifier}/selfsigned";
        };
        before = [ "nixcloud.TLS-selfsigned-certificates.target" ];
        wantedBy = [ "nixcloud.TLS-selfsigned-certificates.target" ];
      }))
    ] else con) [] (attrNames config.nixcloud.TLS.certs);
  in {
    users.groups = fold (identifier: con: con // {
      "${filterIdentifier identifier}" = let c = config.nixcloud.TLS.certs.${identifier}; in { members = c.users; };
    }) {} (attrNames config.nixcloud.TLS.certs);

    # FIXME: use systemd 'DynamicUser' instead of having a declarative user
    users.users = optionalAttrs (acmeSupplied != []) {
      nixcloud-lego-user = {};
    };

    systemd.services = listToAttrs (selfsignedTargets ++ userSuppliedTargets ++ acmeSupplied);

    systemd.targets."nixcloud.TLS-acmeSupplied-certificates" = {
      description = "If reached, all certificates, which were supplied by lego, are in place";
    };

    systemd.targets."nixcloud.TLS-userSupplied-certificates" = {
      description = "If reached, all certificates, which were supplied by the user, were already copied in place to be used";
    };

    systemd.targets."nixcloud.TLS-selfsigned-certificates" = {
      description = "If reached, all self-signed certificates, which were automatically created, were already copied in place to be used";
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

    meta = {
      maintainers = with lib.maintainers; [ qknight ];
    };
  };
}
