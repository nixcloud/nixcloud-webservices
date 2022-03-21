{ config, options, pkgs, lib, ... }:

with lib;

let
  cfg = config.nixcloud.TLS;

  inherit (import ./common.nix { inherit lib; })
    stateDir hashACMEConfig;

  selfSignedCertScript = identifier: subjectAltName: pkgs.writeScriptBin "selfSignedCertScript.sh" ''
    mkdir $RUNTIME_DIRECTORY/selfsigned
    # RANDFILE needs to be defined, otherwise `openssl` attempts to write to `~/.rnd`
    # which will fail when everything else is write-protected
    export RANDFILE=/tmp/rnd

    echo "Create a self signed CA 1/2"
    ${pkgs.openssl.bin}/bin/openssl genrsa -des3 -passout pass:xxxx -out $RUNTIME_DIRECTORY/server.pass.key 2048
    echo "Create a self signed CA 2/2"
    ${pkgs.openssl.bin}/bin/openssl rsa -passin pass:xxxx -in $RUNTIME_DIRECTORY/server.pass.key -out $RUNTIME_DIRECTORY/server.key
    echo "Create a CSR"
    ${pkgs.openssl.bin}/bin/openssl req -new -key $RUNTIME_DIRECTORY/server.key -out $RUNTIME_DIRECTORY/server.csr -subj "/C=DE/ST=Burrow/L=Linux/O=OrgName/OU=nixcloud IT Department"

    echo "Sign the CSR"
    ${pkgs.openssl.bin}/bin/openssl x509 -req -extfile <(printf "subjectAltName=${subjectAltName}") -days 1 -in $RUNTIME_DIRECTORY/server.csr -signkey $RUNTIME_DIRECTORY/server.key -out $RUNTIME_DIRECTORY/server.crt
    echo "Done creating a self signed certificate"
  '';

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
      type = types.attrsOf (types.submodule {
        imports = [ ./cert-options.nix ];
        config = lib.mkIf cfg.testMode {
          mode = lib.mkOverride 90 "selfsigned";
        };
      });
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
    testMode = mkOption {
      type = types.bool;
      default = false;
      internal = true;
      description = ''
        Used by the test runner to make sure all certificates are only
        self-signed and no requests are going out via ACME.
      '';
    };
  };

  config = let
    acmeSupplied = fold (identifier: con: con ++ [
      (nameValuePair "nixcloud.TLS-acmeSupplied-${identifier}" (let
        c = config.nixcloud.TLS.certs.${identifier};
        fallbackEmail = if options.nixcloud.TLS.email.isDefined
                        then config.nixcloud.TLS.email
                        else "info@${c.domain}";
        email = if c.email == null then fallbackEmail else c.email;
        allDomains = concatMapStringsSep " " (x: "--domains=\"${x}\"") (unique ( [ c.domain ] ++ c.extraDomains));
        hash = hashACMEConfig c;
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
          ${pkgs.lego}/bin/lego ${allDomains} --email="${email}" --http --http.webroot="/run/nixcloud/lego/${identifier}/challenges" --path="${path}" --accept-tos --server="${c.acmeApiEndpoint}" renew --days=15
          status=$?
          echo "return code was $status"
          set -e

          if [ "$status" != "0" ]; then
              echo "initial lego certificate query"
              ${pkgs.lego}/bin/lego ${allDomains} --email="${email}" --http --http.webroot="/run/nixcloud/lego/${identifier}/challenges" --path="${path}" --accept-tos --server="${c.acmeApiEndpoint}" run
          fi
        '';
        postStart = ''
          chown root:${filterIdentifier identifier} ${stateDir}/${identifier} -R
          chmod 0750 ${stateDir}/${identifier}/acmeSupplied -R
          systemctl --no-block reload nixcloud.reverse-proxy.service
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
        after = [ "network-online.target" "nixcloud.TLS-acmeSuppliedPreliminary-${identifier}.service" "nixcloud.reverse-proxy.service" ];
        before = [ "nixcloud.TLS-acmeSupplied-certificates.target" ];
        wantedBy = [ "nixcloud.TLS-acmeSupplied-certificates.target" ];
      }))
    ]) [] (filter (x: (config.nixcloud.TLS.certs.${x}.mode == "ACME")) (attrNames config.nixcloud.TLS.certs));

    acmeSuppliedPreliminary = fold (identifier: con: con ++ [
      (nameValuePair "nixcloud.TLS-acmeSuppliedPreliminary-${identifier}" (let
        c = config.nixcloud.TLS.certs.${identifier};
        allDomains = concatMapStringsSep " " (x: "--domains=${x}") ( [ c.domain ] ++ c.extraDomains);
        hash = hashACMEConfig c;
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
            ${selfSignedCertScript identifier subjectAltName}/bin/selfSignedCertScript.sh
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
          cp -n $RUNTIME_DIRECTORY/server.key ${toString tls_certificate_key_path}
          cp -n $RUNTIME_DIRECTORY/server.crt ${toString tls_certificate_path}
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
          #RuntimeDirectory = "nixcloud.TLS-acmeSuppliedPreliminary-${identifier}";
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
          ${selfSignedCertScript identifier subjectAltName}/bin/selfSignedCertScript.sh
          cp -n $RUNTIME_DIRECTORY/server.key ${toString tls_certificate_key_path}
          cp -n $RUNTIME_DIRECTORY/server.crt ${toString tls_certificate_path}
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
          RuntimeDirectory = "nixcloud.TLS-selfsigned-${identifier}";
        };
        unitConfig = {
          # Do not create self-signed key when key already exists
          ConditionPathExists = "!${stateDir}/${identifier}/selfsigned";
        };
        before = [ "nixcloud.TLS-selfsigned-certificates.target" ];
        wantedBy = [ "nixcloud.TLS-selfsigned-certificates.target" ];
      }))
    ]) [] (filter (x: (config.nixcloud.TLS.certs.${x}.mode == "selfsigned")) (attrNames config.nixcloud.TLS.certs));
  in lib.mkIf (config.nixcloud.TLS.certs != {}) {

    assertions = let
      nixcloudTLSonlyACMETypedLists = filterAttrs (n: v: v.mode == "ACME") config.nixcloud.TLS.certs;
      nixcloudTLSonlyACMETypedUniqueListsAllExtraDomains = unique (fold (el: c: nixcloudTLSonlyACMETypedLists.${el}.extraDomains ++ c) [] (attrNames nixcloudTLSonlyACMETypedLists));
      # if duplicate entries exist, it returns a set of { "domain" : [ "identifier1" "identifier1" ]; }
      # findDupsED returns [ "identifier1" "identifier2" ] or [];
      findDupsED = domain: fold (el: c: c ++ (if (any (x: x == domain) nixcloudTLSonlyACMETypedLists.${el}.extraDomains) then [ "${el}" ] else [] )) [] (attrNames nixcloudTLSonlyACMETypedLists);
      #extraDomainEntries = { "debug.com" = []; };
      extraDomainEntries = fold (el: c: c // { "${el}" = (findDupsED el); } ) {} nixcloudTLSonlyACMETypedUniqueListsAllExtraDomains;
      # remove all elements where there is only one child (no collision)
      #duplicatedExtraDomainEntries = { "domain" = [ "identifier1" "identifier2" ]; "domain2" = [ "identifier1" "identifier2" ]; };
      duplicatedExtraDomainEntries = filterAttrs (n: v: length v > 1) extraDomainEntries;
      duplicatedExtraDomainEntriesLine = domain: identifiers: "  * ${domain} = found in identifier(s) [${fold (el: c: " \"${el}\"" + c) "" identifiers} ]";
      duplicatedExtraDomainEntriesErrorString = "The domains in question: " + fold (el: c: "\n" + duplicatedExtraDomainEntriesLine el duplicatedExtraDomainEntries.${el} + c) "" (attrNames duplicatedExtraDomainEntries) +
        "\nRemove the duplicate entries so we can create a valid nixcloud.reverse-proxy configuration for lego (ACME) common challenges directory!";
      # for ACME typed identifiers: two different identifiers, with the same domain set, must result in an error
      nixcloudTLSonlyACMETypedUniqueListsAllDomains = unique (fold (el: c: [ nixcloudTLSonlyACMETypedLists.${el}.domain ] ++ c) [] (attrNames nixcloudTLSonlyACMETypedLists));
      # findDupsED returns [ "identifier1" "identifier2" ] or [];
      findDupsD = domain: fold (el: c: c ++ (if (domain == nixcloudTLSonlyACMETypedLists.${el}.domain) then [ "${el}" ] else [] )) [] (attrNames nixcloudTLSonlyACMETypedLists);
      domainEntries = fold (el: c: c // { "${el}" = (findDupsD el); } ) {} nixcloudTLSonlyACMETypedUniqueListsAllDomains;
      #duplicatedDomainEntries = { "domain" = [ "identifier1" "identifier2" ]; "domain2" = [ "identifier1" "identifier2" ]; };
      duplicatedDomainEntries = filterAttrs (n: v: length v > 1) domainEntries;
      duplicatedDomainEntriesLine = domain: identifiers: "  * ${domain} = found in identifier(s) [${fold (el: c: " \"${el}\"" + c) "" identifiers} ]";
      duplicatedDomainEntriesErrorString = "The domain in question: " + fold (el: c: "\n" + duplicatedDomainEntriesLine el duplicatedDomainEntries.${el} + c) "" (attrNames duplicatedDomainEntries) +
        "\nRemove the duplicate domain entry so we can create a valid nixcloud.reverse-proxy configuration for lego (ACME) common challenges directory!";
    in [
      { assertion = duplicatedDomainEntries == {};
        message = "nixcloud.TLS: Two different identifier's domain(s) (both ACME typed), in nixcloud.TLS.certs.<identifier>.domain, contain the same domain.\n${duplicatedDomainEntriesErrorString}";
      }
      { assertion = duplicatedExtraDomainEntries == {};
        message = "nixcloud.TLS: Two different identifier's extraDomains (both ACME typed), in nixcloud.TLS.certs.<identifier>.extraDomains, contain the same domains while these lists must contain unique elements only.\n${duplicatedExtraDomainEntriesErrorString}";
      }
      # assertion only relevant if nixos 18.03 was used before
      { assertion = lib.versionAtLeast (getVersion pkgs.lego) "1.0.0";
        message = "lego version '${getVersion pkgs.lego}' too old, you need to update to 18.09 (or nixpkgs unstable)";
      }
    ];

    users.groups = (fold (identifier: con: con // {
      "${filterIdentifier identifier}" = let c = config.nixcloud.TLS.certs.${identifier}; in { members = c.users; };
    }) {} (attrNames config.nixcloud.TLS.certs))
    // optionalAttrs (acmeSupplied != []) {
      nixcloud-lego-user = {};
    };

    users.users = optionalAttrs (acmeSupplied != []) {
      nixcloud-lego-user = {
        isSystemUser = true;
        group = "nixcloud-lego-user";
      };
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
