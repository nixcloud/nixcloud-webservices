# Note that the options in this file are NOT NixOS configuration options, we
# only use the NixOS module system to check the types.
{ pkgs, config, lib, ... }:

let
  inherit (lib) mkOption types;

  ruleModule.options = {
    direction = mkOption {
      type = types.enum [ "incoming" "outgoing" ];
      default = "incoming";
      example = "outgoing";
      description = ''
        Which kind of network operation to remap to UNIX Domain Sockets.

        If the value is <literal>incoming</literal> all calls to <citerefentry>
          <refentrytitle>listen</refentrytitle>
          <manvolnum>2</manvolnum>
        </citerefentry> are redirected.

        If the value is <literal>outgoing</literal> all calls to <citerefentry>
          <refentrytitle>connect</refentrytitle>
          <manvolnum>2</manvolnum>
        </citerefentry> are redirected.
      '';
    };

    type = mkOption {
      type = types.nullOr (types.enum [ "tcp" "udp" ]);
      default = null;
      example = "udp";
      description = ''
        The socket type for this rule to match. If the value is
        <literal>null</literal> then both TCP and UDP types are matched.
      '';
    };

    address = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "127.0.0.1";
      description = ''
        The IPv4 or IPv6 address to match when deciding whether to use UNIX
        Domain Sockets. If the value is <literal>null</literal> then it matches
        always.
      '';
    };

    port = mkOption {
      type = types.nullOr types.ints.u16;
      default = null;
      example = 443;
      description = ''
        The TCP or UDP port to match when deciding whether to use UNIX Domain
        Sockets. If the value is <literal>null</literal> then it matches
        always.
      '';
    };

    socketPath = mkOption {
      type = types.nullOr types.path;
      default = null;
      example = "/run/foo.socket";
      description = ''
        The path of the UNIX Domain Socket to connect or listen on. If the
        value is <literal>null</literal>, <option>socketActivation</option> has
        to be enabled instead.
      '';
    };

    socketActivation = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to use an existing file descriptor instead of binding to a
        socket for use with a <citerefentry>
          <refentrytitle>systemd.socket</refentrytitle>
          <manvolnum>5</manvolnum>
        </citerefentry>.
      '';
    };

    fdName = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        If <option>socketActivation</option> is enabled this specifies the file
        descriptor name to use instead of using the first one available.

        See the <literal>FileDescriptorName</literal> option in <citerefentry>
          <refentrytitle>systemd.socket</refentrytitle>
          <manvolnum>5</manvolnum>
        </citerefentry> for more information.
      '';
    };
  };

in {
  options.program = mkOption {
    type = types.path;
    example = lib.literalExample "\${pkgs.nginx}/bin/nginx";
    description = ''
      The program to wrap with a LD_PRELOAD wrapper that transform IP sockets
      to UNIX Domain Sockets according to <option>rules</option>.
    '';
  };

  options.useBinDir = mkOption {
    type = types.bool;
    default = false;
    description = ''
      By default, the wrapper of the <option>program</option> is generated as
      an executable file directly inside the store without any <filename
      class="directory">bin/</filename> subdirectory. If this option is set to
      <literal>true</literal>, such a directory is created and the wrapper is
      put inside with the same <citerefentry>
        <refentrytitle>basename</refentrytitle>
        <manvolnum>1</manvolnum>
      </citerefentry> as the <option>program</option>.
    '';
  };

  options.baseName = mkOption {
    type = types.strMatching "[a-zA-Z0-9+_?=-][a-zA-Z0-9.+_?=-]*";
    example = "socket-curl";
    description = ''
      Specify a specific base name to use for the <option>program</option>
      wrapper. By default this is the <citerefentry>
        <refentrytitle>basename</refentrytitle>
        <manvolnum>1</manvolnum>
      </citerefentry> of the <option>program</option>.
    '';
  };

  options.rules = mkOption {
    type = types.listOf (types.submodule ruleModule);
    default = [];
    example = [
      { direction = "incoming";
        port = 80;
        socketPath = "/run/my-webserver.socket";
      }
      { direction = "outgoing";
        address = "127.0.0.1";
        socketPath = "/run/some-reverse-proxied-service.socket";
      }
    ];
    description = ''
      A list of rules specifying which IP sockets to match and either the UNIX
      Domain Sockets to use instead or whether to use systemd socket
      activation.
    '';
  };

  options.__result = mkOption {
    type = types.unspecified;
    internal = true;
    description = "The resulting wrapper derivation.";
  };

  config.baseName = lib.mkDefault
    (baseNameOf (builtins.unsafeDiscardStringContext config.program));

  config.__result = let
    mkCcStr = val: let
      escaped = lib.replaceStrings ["\"" "\\" "\n"] ["\\\"" "\\\\" "\\n"] val;
    in "\"${escaped}\"";

    mkCcOptional = f: val: if val == null then "std::nullopt" else f val;

    assertions = rule: [
      { assertion = rule.socketPath == null -> rule.socketActivation;
        message = "You need to either specify a 'socketPath' or enable socket"
                + " activation using 'socketActivation = true'.";
      }
      { assertion = rule.socketActivation -> rule.direction == "incoming";
        message = "If 'socketActivation' is enabled the rule direction has to"
                + " be 'incoming', but it is '${rule.direction}' instead.";
      }
    ];

    mkRuleStruct = rnum: rule: let
      # C++ doesn't have tagged structure member tags as C does, so we need to
      # retain the correct order:
      fields = [
        # field 1: rule_direction direction;
        { incoming = "rule_direction::INCOMING";
          outgoing = "rule_direction::OUTGOING";
        }.${rule.direction}
        # field 2: std::optional<rule_ip_type> type;
        (mkCcOptional (lib.flip builtins.getAttr {
          tcp = "rule_ip_type::TCP";
          udp = "rule_ip_type::UDP";
        }) rule.type)
        # field 3: std::optional<std::string> address;
        (mkCcOptional mkCcStr rule.address)
        # field 4: std::optional<uint16_t> port;
        (mkCcOptional toString rule.port)
        # field 5: bool socket_activation;
        (lib.boolToString rule.socketActivation)
        # field 6: std::optional<std::string> fd_name;
        (mkCcOptional mkCcStr rule.fdName)
        # field 7: std::optional<std::string> socket_path;
        (mkCcOptional mkCcStr rule.socketPath)
      ];

      failedAssertions = lib.filter (x: !x.assertion) (assertions rule);
      failures = map (x: x.message) failedAssertions;
      messages = lib.concatMapStringsSep "\n" (x: "- ${x}") failures;
      msg = "\nFailed assertions in rule ${toString rnum} for the UNIX"
          + " Domain Socket wrapper of ${config.program}:\n${messages}";
      result = "  { ${lib.concatStringsSep ",\n    " fields}\n  }";

    in if failedAssertions == [] then result else throw msg;

  in pkgs.runCommandCC "${config.baseName}-wrapped" rec {
    src = ./preload.cc;
    inherit (config) program useBinDir baseName;

    ruleFile = let
      name = "${config.baseName}-rules.h";
      structs = lib.imap1 mkRuleStruct config.rules;
    in pkgs.writeText name (lib.concatStringsSep ",\n" structs);

    hasSocketActivation = lib.any (r: r.socketActivation) config.rules;
    nativeBuildInputs = lib.optional hasSocketActivation pkgs.pkgconfig;
    buildInputs = lib.optional hasSocketActivation pkgs.systemd;
  } ''
    if [ -n "$useBinDir" ]; then
      mkdir -p "$out/bin"
      outFile="$out/bin/$baseName"
    else
      outFile="$out"
    fi

    if [ -n "$hasSocketActivation" ]; then
      systemdArgs="$(pkg-config --cflags --libs libsystemd)"
      systemdArgs+=" -DSOCKET_ACTIVATION"
    else
      systemdArgs=""
    fi

    c++ $systemdArgs -fPIC -pie -ldl -Wall -std=gnu++17 "$src" -o "$outFile" \
      -Wl,-E -DPROGRAM_PATH="\"$program\"" -DUDSMAP_RULE_FILE="\"$ruleFile\""
  '';
}
