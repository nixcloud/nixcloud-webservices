{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.nixcloud.TLS;
  stateDir = "/var/lib/nixcloud/TLS/";

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

  certOpts = { name, ... } @ toplevel: {
    options = {
      domain = mkOption {
        type = nixcloudTLSDomainType;
        default = name;
        description = ''
          Domain to fetch certificate for (defaults to the entry name)
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
        example = [ "postifx.service" ];
        description = ''
          A list of systemd services which are <emphasis>reloaded</emphasis>
          after certificates are re-issued. A service is only
          <emphasis>reloaded</emphasis> once, even when mentioned serveral
          times in this list. It is not reloaded if it is also listed in the
          <option>restart</option> list, then it is only restarted.
        '';
      };
      restart = mkOption {
        type = nixcloudRestartType;
        default = [];
        apply = x: unique x;
        example = [ "postifx.service" ];
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
            <filename class="directory">/var/lib/nixcloud/TLS</filename> and
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
            if toplevel.config.mode == "ACME" then "/var/lib/acme/${name}/key.pem" else
            if toplevel.config.mode == "selfsigned" then "/var/lib/nixcloud/TLS/${name}/selfsigned/key.pem" else
            "/undefined1"
          else if isAttrs toplevel.config.mode then "/var/lib/nixcloud/TLS/${name}/usersupplied/key.pem" else
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
            if toplevel.config.mode == "ACME" then "/var/lib/acme/${name}/fullchain.pem" else
            if toplevel.config.mode == "selfsigned" then "/var/lib/nixcloud/TLS/${name}/selfsigned/fullchain.pem" else
            "/undefined1_"
          else if isAttrs toplevel.config.mode then "/var/lib/nixcloud/TLS/${name}/usersupplied/fullchain.pem" else
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
  options.nixcloud.TLS.certs = mkOption {
    default = {};
    type = types.attrsOf (types.submodule certOpts);
    description = ''
      Attribute set of certificates to be used by various NixOS services.
    '';
    example = literalExample ''
      "example.com" = {
        email = "foo@example.com";
        reload = [ "postifx.service" "myservice.service" ];
      };
    '';
  };

  config = let
    usersuppliedTargets = fold (cert: con: if isAttrs config.nixcloud.TLS.certs.${cert}.mode then con ++ [
      (nameValuePair "nixcloud.TLS-usersupplied-${cert}" (let
        c = config.nixcloud.TLS.certs.${cert};
        tls_certificate =     c.mode.tls_certificate;
        tls_certificate_key = c.mode.tls_certificate_key;
      in {
        description = "nixcloud.TLS: create usersupplied certificate for ${cert}";

        script = ''
          rm -Rf /var/lib/nixcloud/TLS/${cert}/usersupplied # should not be needed
          TMPDIR=$(mktemp -d usersupplied-${cert}.XXXXXXXXXX --tmpdir)
          mkdir $TMPDIR/usersupplied

          cp ${toString tls_certificate_key} $TMPDIR/usersupplied/key.pem
          cp ${toString tls_certificate} $TMPDIR/usersupplied/fullchain.pem

          chmod 0700 $TMPDIR/usersupplied
          mkdir -p ${stateDir}/${cert}/
          chmod 0755 ${stateDir}
          mv $TMPDIR/usersupplied /var/lib/nixcloud/TLS/${cert}/
        '';
        serviceConfig = {
          Type = "oneshot";
          RuntimeDirectory = "nixcloud.TLS-acme-usersupplied-${cert}";
        };
        before = [ "nixcloud.TLS-usersupplied-certificates.target" ];
        wantedBy = [ "nixcloud.TLS-usersupplied-certificates.target" ];
      }))
    ] else con) [] (attrNames config.nixcloud.TLS.certs);

    selfsignedTargets = fold (cert: con: if ((config.nixcloud.TLS.certs.${cert}.mode) == "selfsigned") then con ++ [
      (nameValuePair "nixcloud.TLS-selfsigned-${cert}" (let
        c = config.nixcloud.TLS.certs.${cert};
      in {
        description = "nixcloud.TLS: create preliminary self-signed certificate for ${cert}";

        script = ''
          rm -Rf /var/lib/nixcloud/TLS/${cert}/selfsigned # should not be needed
          TMPDIR=$(mktemp -d selfsigned-${cert}.XXXXXXXXXX --tmpdir)
          mkdir $TMPDIR/selfsigned

          # Create self-signed key
          workdir=$(mktemp -d selfsigned-${cert}.XXXXXXXXXX --tmpdir)
          ${pkgs.openssl.bin}/bin/openssl genrsa -des3 -passout pass:x -out $workdir/server.pass.key 2048
          ${pkgs.openssl.bin}/bin/openssl rsa -passin pass:x -in $workdir/server.pass.key -out $workdir/server.key
          ${pkgs.openssl.bin}/bin/openssl req -new -key $workdir/server.key -out $workdir/server.csr \
            -subj "/C=UK/ST=Warwickshire/L=Leamington/O=OrgName/OU=IT Department/CN=example.com"
          ${pkgs.openssl.bin}/bin/openssl x509 -req -days 1 -in $workdir/server.csr -signkey $workdir/server.key -out $workdir/server.crt
          # Move key to destination
          mv $workdir/server.key $TMPDIR/selfsigned/key.pem
          mv $workdir/server.crt $TMPDIR/selfsigned/fullchain.pem

          chmod 0700 $TMPDIR/selfsigned
          mkdir -p ${stateDir}/${cert}/
          chmod 0755 ${stateDir}
          mv $TMPDIR/selfsigned /var/lib/nixcloud/TLS/${cert}/
        '';
        serviceConfig = {
          Type = "oneshot";
          RuntimeDirectory = "nixcloud.TLS-acme-selfsigned-${cert}";
        };
        unitConfig = {
          # Do not create self-signed key when key already exists
          ConditionPathExists = "!/var/lib/nixcloud/TLS/${cert}/selfsigned";
        };
        before = [ "nixcloud.TLS-selfsigned-certificates.target" ];
        wantedBy = [ "nixcloud.TLS-selfsigned-certificates.target" ];
      }))
    ] else con) [] (attrNames config.nixcloud.TLS.certs);
  in {
    security.acme.preliminarySelfsigned = true;
    security.acme.certs = fold (cert: con: if config.nixcloud.TLS.certs.${cert}.mode == "ACME" then con // {
      "${cert}" = let c = config.nixcloud.TLS.certs.${cert}; in {
        domain = "${c.domain}";
        email = c.email;
        webroot = "/var/lib/acme/acme-challenges";
        postRun = ''
          ${lib.concatStringsSep "\n" (map (el: "  systemctl restart ${el}") c.restart)}
          ${lib.concatStringsSep "\n" (map (el: "  systemctl reload ${el}") c.reload)}
        '';
      };
    } else con) {} (attrNames config.nixcloud.TLS.certs);

    systemd.services = listToAttrs (selfsignedTargets ++ usersuppliedTargets);

    systemd.targets."nixcloud.TLS-usersupplied-certificates" = {
      description = "If reached, all certificates, which were supplied by the user, were already copied in place to be used";
    };

    systemd.targets."nixcloud.TLS-selfsigned-certificates" = {
      description = "If reached, all self-signed certificates, which were automatically created, were already copied in place to be used";
    };

    systemd.targets."nixcloud.TLS-certificates" = {
      description = "If reached, all certificates managed via nixcloud.TLS have been put into place to be used";

      wantedBy = [ "multi-user.target" ];

      after =
        # security.acme
           [ "acme-selfsigned-certificates.target" ]
        ++ [ "acme-certificates.target" ]
        # nixcloud.TLS
        ++ [ "nixcloud.TLS-usersupplied-certificates.target" ]
        ++ [ "nixcloud.TLS-selfsigned-certificates.target" ];

      wants =
        # security.acme
           [ "acme-selfsigned-certificates.target" ]
        ++ [ "acme-certificates.target" ]
        # nixcloud.TLS
        ++ [ "nixcloud.TLS-usersupplied-certificates.target" ]
        ++ [ "nixcloud.TLS-selfsigned-certificates.target" ];
    };

    meta = {
      maintainers = with lib.maintainers; [ qknight ];
    };
  };
}
