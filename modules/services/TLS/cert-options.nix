{ name, config, lib, ... }:

let
  inherit (lib) mkOption types;
  identifier = name;

  inherit (import ./common.nix { inherit lib; })
    stateDir hashACMEConfig;

  nixcloudTLSDomainType = lib.mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.domain";
    check = x: (lib.isString x && x != "")
      || isNull x;
    merge = lib.mergeEqualOption;
  };

  nixcloudTLSEmailType = lib.mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.email";
    check = x: (lib.isString x && x != "");
    merge = lib.mergeEqualOption;
  };

  acmeApiEndpointType = lib.mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.acmeApiEndpoint";
    check = x: (lib.isString x && x != "");
    merge = lib.mergeEqualOption;
  };

  nixcloudTLSModeType = lib.mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.mode";
    merge = lib.mergeEqualOption;
    check = x: ((lib.isString x && x == "ACME")
        || (lib.isString x && x == "selfsigned")
        || ((lib.isAttrs x || lib.isFunction x) && x ? tls_certificate_key && x ? tls_certificate));
  };

  c = x: lib.isList x && lib.fold (el: c: if (lib.isString el) then c else false) true x;
  m = loc: defs: lib.unique (lib.fold (el: c: el.value ++ c) [] defs);

  nixcloudExtraDomainsType = lib.mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.extraDomains";
    check = c;
    merge = m;
  };
  nixcloudUsersType = lib.mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.users";
    check = c;
    merge = m;
  };
  nixcloudReloadType = lib.mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.reload";
    check = c;
    merge = m;
  };
  nixcloudRestartType = lib.mkOptionType {
    name = "nixcloud.TLS.certs.<identifier>.restart";
    check = c;
    merge = m;
  };

in {
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
      example = lib.literalExample ''
        [ "example.org" "mydomain.org" ]
      '';
      apply = x: lib.unique x;
      description = ''
        A list of extra domain names, which are included in the one
        certificate to be issued.
      '';
    };
    reload = mkOption {
      type = nixcloudReloadType;
      apply = x: lib.subtractLists config.restart (lib.unique x);
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
      apply = x: lib.unique x;
      example = [ "postfix.service" ];
      description = ''
        A list of systemd services which are <emphasis>restarted</emphasis>
        after certificates are re-issued. A service is only
        <emphasis>restarted</emphasis> once, even when mentioned serveral
        times in this list.
      '';
    };
    email = mkOption {
      type = types.nullOr nixcloudTLSEmailType;
      default = null;
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
        if lib.isString config.mode then
          if config.mode == "ACME" then "${stateDir}/${identifier}/acmeSupplied/${hashACMEConfig config}/certificates/${config.domain}.key" else
          if config.mode == "selfsigned" then "${stateDir}/${identifier}/selfsigned/key.pem" else
          "/undefined1"
        else if lib.isAttrs config.mode then "${stateDir}/${identifier}/userSupplied/key.pem" else
          "/undefined2";
      defaultText = "${stateDir}/\${identifier}/.../key.pem";
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
        if lib.isString config.mode then
          if config.mode == "ACME" then "${stateDir}/${identifier}/acmeSupplied/${hashACMEConfig config}/certificates/${config.domain}.crt" else
          if config.mode == "selfsigned" then "${stateDir}/${identifier}/selfsigned/fullchain.pem" else
          "/undefined1_"
        else if lib.isAttrs config.mode then "${stateDir}/${identifier}/userSupplied/fullchain.pem" else
          "/undefined2_";
      defaultText = "${stateDir}/\${identifier}/.../fullchain.pem";
      description = ''
        Internally set option (read only) which points to the
        <filename>fullchain.pem</filename> file, depending on the
        <option>nixcloud.TLS.certs.&lt;name&gt;.mode</option> setting.
      '';
    };
  };
}
