# Note that the options in this file are NOT NixOS configuration options, we
# only use the NixOS module system to check the types.
{ pkgs, config, lib, ... }:

let
  inherit (lib) mkOption types;

  ruleModule.options = {
    direction = mkOption {
      type = types.nullOr (types.enum [ "incoming" "outgoing" ]);
      default = null;
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

        If the value is <literal>null</literal> both incoming and outgoing
        connections are redirected.
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

    portEnd = mkOption {
      type = types.nullOr types.ints.u16;
      default = null;
      example = 2000;
      description = ''
        Specifies an inclusive port range from <option>port</option> to the
        value specified here.
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

    reject = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Wether to reject <citerefentry>
          <refentrytitle>bind</refentrytitle>
          <manvolnum>2</manvolnum>
        </citerefentry> and <citerefentry>
          <refentrytitle>connect</refentrytitle>
          <manvolnum>2</manvolnum>
        </citerefentry> syscalls.
        By default, error code <errorcode>EACCES</errorcode> is used, unless
        <option>rejectError</option> is specified.
      '';
    };

    rejectError = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "EADDRINUSE";
      description = ''
        The error code to use instead of the default
        <errorcode>EACCES</errorcode> if <option>reject</option> is
        <literal>true</literal>.
      '';
    };

    blackhole = mkOption {
      type = types.bool;
      default = false;
      description = ''
        When binding the socket, use a temporary file system path and
        <citerefentry>
          <refentrytitle>unlink</refentrytitle>
          <manvolnum>2</manvolnum>
        </citerefentry> it shortly after the <citerefentry>
          <refentrytitle>bind</refentrytitle>
          <manvolnum>2</manvolnum>
        </citerefentry>. This is a way to deactivate a specific socket without
        the application noticing.
      '';
    };
  };

in {
  options.program = mkOption {
    type = types.nullOr types.path;
    default = null;
    example = lib.literalExample "\${pkgs.nginx}/bin/nginx";
    description = ''
      The program to wrap with a LD_PRELOAD wrapper that transform IP sockets
      to UNIX Domain Sockets according to <option>rules</option>. If the value
      is <literal>null</literal> the resulting wrapper can be applied to any
      program.
    '';
  };

  options.makeWrapperArgs = mkOption {
    type = types.listOf types.str;
    default = [];
    example = [ "--prefix" "PATH" ":" "/foo/bar" ];
    description = ''
      Additional arguments to provide to the <command>makeWrapper</command>
      command.
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
    assertions = rule: [
      { assertion = rule.blackhole -> rule.direction == "incoming";
        message = "Only incoming sockets can be blackholed.";
      }
      { assertion = rule.portEnd != null -> rule.port != null;
        message = "An ending port was specified without a starting port.";
      }
      { assertion = rule.port != null && rule.portEnd != null
                 -> rule.port < rule.portEnd;
        message = "Starting port in port range needs to be smaller than"
                + " ending port.";
      }
      { assertion = rule.socketPath != null
                 || rule.socketActivation
                 || rule.reject
                 || rule.blackhole;
        message = "You need to either specify a 'socketPath', enable socket"
                + " activation using 'socketActivation = true', enable"
                + " 'reject' or 'blackhole'.";
      }
      { assertion = rule.socketActivation -> rule.direction == "incoming";
        message = "If 'socketActivation' is enabled the rule direction has to"
                + " be 'incoming', but it is '${rule.direction}' instead.";
      }
    ];

    mkRule = rnum: rule: let
      failedAssertions = lib.filter (x: !x.assertion) (assertions rule);
      failures = map (x: x.message) failedAssertions;
      messages = lib.concatMapStringsSep "\n" (x: "- ${x}") failures;
      msg = "\nFailed assertions in rule ${toString rnum} for the UNIX"
          + " Domain Socket wrapper of ${config.program}:\n${messages}";
      result = let
        # The names here are the option names and the values are matched
        # accordingly and if they match, the option will be excluded.
        includedOptions = {
          direction = null;
          type = null;
          address = null;
          port = null;
          portEnd = null;
          socketPath = null;
          socketActivation = false;
          fdName = null;
          reject = false;
          rejectError = null;
          blackhole = false;
        };
        filterCond = name: val: includedOptions.${name} or val != val;
      in lib.filterAttrs filterCond rule;
    in if failedAssertions == [] then result else throw msg;

  in pkgs.runCommand "${config.baseName}-wrapped" rec {
    inherit (config) program useBinDir baseName;
    nativeBuildInputs = [ pkgs.makeWrapper ];

    # TODO: Remove this as soon as it is in the oldest nixpkgs version we
    #       support.
    ip2unix = pkgs.stdenv.mkDerivation rec {
      name = "ip2unix-${version}";

      version = "1.1.1";

      src = pkgs.fetchFromGitHub {
        owner = "nixcloud";
        repo = "ip2unix";
        rev = "v${version}";
        sha256 = "0lw4f1p1frfpf5l7faqdd80d6pi9g5sx7g3wpmig9sa50k6pmc0v";
      };

      nativeBuildInputs = [
        pkgs.meson pkgs.ninja pkgs.pkgconfig pkgs.asciidoctor
        pkgs.python3Packages.pytest pkgs.python3Packages.pytest-timeout
      ];
      buildInputs = [ pkgs.libyamlcpp pkgs.systemd ];

      doCheck = true;
    };

    rulesFile = let
      name = "${config.baseName}-rules.json";
      rules = lib.imap1 mkRule config.rules;
    in pkgs.writeText name (builtins.toJSON rules);
  } ''
    "$ip2unix/bin/ip2unix" -c -f "$rulesFile"

    if [ -n "$useBinDir" ]; then
      mkdir -p "$out/bin"
      outFile="$out/bin/$baseName"
    else
      outFile="$out"
    fi

    makeWrapper "$ip2unix/bin/ip2unix" "$outFile" \
      --add-flags "-f '$rulesFile' -- $program" \
      ${lib.escapeShellArgs config.makeWrapperArgs}
  '';
}
