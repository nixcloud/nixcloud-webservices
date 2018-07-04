# Run run-webservice.sh --help to see an explanation on what this does.
{ system ? builtins.currentSystem, wsConfig ? {}, httpPort ? 3000 }:

let
  lib = import <nixpkgs/lib>;

  mkConfig = wsName: { config, pkgs, lib, ... }: let
    sshKeyPair = pkgs.runCommand "ssh-keypair" {
      buildInputs = [ pkgs.openssh ];
    } ''
      mkdir "$out"
      ssh-keygen -t ed25519 -f "$out/key" -N "" -C "$keyComment"
    '';

    # Display HTML messages via w3m in mutt using the v key.
    mailcap = let
      mkEntry = attrs: let
        optAttrs = removeAttrs attrs [ "command" ];
        mkOpt = key: val:
          if val == true then key
          else if val == false then null
          else "${key}=${val}";
        opts = lib.remove null (lib.mapAttrsToList mkOpt optAttrs);
      in lib.concatStringsSep "; " ([ attrs.type attrs.command ] ++ opts);
    in pkgs.writeText "mailcap" (lib.concatMapStringsSep "\n" mkEntry [
      { type = "text/html";
        command = "${pkgs.w3m}/bin/w3m -T text/html '%s'";
        needsterminal = true;
        description = "HTML Text";
        nametemplate = "%s.html";
      }
      { type = "text/html";
        command = "${pkgs.w3m}/bin/w3m -T text/html '%s'";
        copiousoutput = true;
        description = "HTML Text";
        nametemplate = "%s.html";
      }
    ]);

  in {
    imports = [
      ./modules
      { nixcloud.webservices.${wsName}.dev = wsConfig; }
    ];

    nixcloud.reverse-proxy.enable = true;

    nixcloud.webservices.${wsName}.dev = {
      enable = true;
      proxyOptions.TLS = "none";
      proxyOptions.domain = "localhost";
      proxyOptions.http.mode = "on";
      proxyOptions.https.mode = "off";
      proxyOptions.port = httpPort;

      # XXX: Work around the reverse-proxy module implementation.
      proxyOptions.ip = "localhost";
      proxyOptions.http.flags = lib.mkForce ''
        proxy_set_header Host "localhost:${toString httpPort}";
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_pass http://$targetIP:$targetPort$request_uri;
      '';
    };

    # Don't ever try to retrieve TLS certificates via ACME.
    # FIXME: Disabling this should probably be an option instead.
    nixcloud.TLS.certs = lib.mkForce {};

    # Don't run tests during build, because we quickly want to have a
    # development environment set up.
    nixcloud.tests.enable = false;

    environment.systemPackages = [
      pkgs.htop pkgs.vim_configurable

      # Patch mutt so that it expands hostnames and displays HTML.
      (pkgs.mutt.overrideAttrs (attrs: {
        configureFlags = (attrs.configureFlags or []) ++ [
          "--with-domain=${config.networking.hostName}"
        ];
        postInstall = (attrs.postInstall or "") + ''
          cat >> "$out/etc/Muttrc" <<MUTTRC
          alternative_order text/plain text/enriched text/html
          auto_view text/html
          bind attach <return> view-mailcap
          set ascii_chars=yes
          set folder = \$MAIL
          set mailcap_path = ${mailcap}
          set sort=threads
          MUTTRC
        '';
      }))
    ];

    programs.bash.promptInit = let
      promptHost = lib.escapeShellArg "${wsName}-dev";
    in ''
      if [ "$TERM" != "dumb" ]; then
        PROMPT_COLOR="1;33m"
        let $UID && PROMPT_COLOR="1;32m"
        PS1="\n\[\033[1;33m\]["${promptHost}":\w]\\$\[\033[m\] "
        if [ "$TERM" = xterm ]; then
          PS1="\[\033]2;"${promptHost}":\w\007\]$PS1"
        fi
      fi
    '';

    networking.hostName = "nixcloud-dev";
    networking.firewall.enable = false;

    # This makes sure that Postfix catches all outgoing mail into the root
    # users mailbox.
    services.postfix.enable = true;
    services.postfix.virtual = "/.*/ root\n";
    services.postfix.virtualMapType = "regexp";
    services.postfix.config = {
      inet_interfaces = "127.0.0.1";
      virtual_alias_domains = "";
    };

    services.openssh.enable = true;

    # We want to have *every* message, even if it's flooding like hell.
    services.journald.rateLimitInterval = "0";

    system.build.wrapped-vm = let
      # Remove permission checks on private key as we're using a snakeoil key
      # anyway and on non-NixOS systems the permissions for files within the
      # store are not necessarily good enough for OpenSSH.
      patchedSsh = pkgs.openssh.overrideAttrs (drv: {
        postPatch = (drv.postPatch or "") + ''
          sed -i -e 's/sshkey_perm_ok( *[a-zA-Z0-9_]\+ *,[^)]\+)/0/g' *.c
        '';
      });

      sleep = lib.escapeShellArg "${pkgs.coreutils}/bin/sleep";
      nc = lib.escapeShellArg "${pkgs.netcat-openbsd}/bin/nc";
      ssh = lib.escapeShellArg "${patchedSsh}/bin/ssh";
    in pkgs.writeScript "run-vm" ''
      #!${pkgs.stdenv.shell}

      # First send a SIGTERM signal to the VM and if it doesn't quit within 20
      # seconds, send a SIGKILL signal.
      kill_everything() {
        retry=0
        while kill -0 $(jobs -p); do
          if [ $retry -ge 20 ]; then
            kill -9 $(jobs -p)
          else
            kill $(jobs -p)
          fi
          retry=$(($retry + 1))
          ${sleep} 1
        done 2> /dev/null || :
      }

      waitport_ssh() {
        while ! ${nc} -z 127.0.0.1 "$1"; do ${sleep} 0.1; done
        while ! ${nc} -w1 127.0.0.1 "$1" < /dev/null | grep -q -m1 '^SSH-'; do
          ${sleep} 0.1
        done
      }

      trap kill_everything EXIT

      set -e

      ${nc} -u -l 127.0.0.1 3332 &
      ncpid=$!

      ${lib.escapeShellArg config.system.build.vm}/bin/run-*-vm \
        -monitor tcp:127.0.0.1:3331,server,nowait \
        -serial udp:127.0.0.1:3332 \
        "$@" &
      vmpid=$!

      waitport_ssh 3022

      set +e
      ${ssh} \
        -i ${lib.escapeShellArg "${sshKeyPair}/key"} \
        -o UserKnownHostsFile=/dev/null \
        -o GlobalKnownHostsFile=/dev/null \
        -o StrictHostKeyChecking=no \
        -o ConnectionAttempts=10 \
        -p 3022 root@localhost
      retval=$?
      set -e

      echo system_powerdown | ${nc} 127.0.0.1 3331 > /dev/null
      wait $vmpid || :
      exit $retval
    '';

    systemd.services."serial-getty@ttyS0".enable = false;
    systemd.services."serial-getty@hvc0".enable = false;

    environment.etc."ssh/authorized_keys.d/root" = lib.mkForce {
      mode = "0444";
      source = "${sshKeyPair}/key.pub";
    };

    virtualisation.diskSize = 16384;
    virtualisation.memorySize = 1024;
    virtualisation.graphics = false;

    virtualisation.qemu.networkingOptions = let
      devOpts = lib.concatStringsSep "," [
        "hostfwd=tcp:127.0.0.1:${toString httpPort}-:80"
        "hostfwd=tcp:127.0.0.1:3022-:22"
      ];
    in [
      "-net nic,vlan=0,model=virtio"
      "-net user,vlan=0,${devOpts}\${QEMU_NET_OPTS:+,$QEMU_NET_OPTS}"
    ];

    virtualisation.qemu.options = [ "-device virtio-rng-pci" ];
  };

  # Creates a shell script which runs a VM with the given web service name and
  # additional web service config.
  mkRunner = wsName: (import <nixpkgs/nixos/lib/eval-config.nix> {
    inherit system;
    modules = [
      (mkConfig wsName) <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
    ];
  }).config.system.build.wrapped-vm;

  # A list of all the names of available web services, which we need to allow
  # building of this file using something like:
  #
  #   nix-build run-webservice.nix -A leaps
  #
  availableWS = let
    eval = import <nixpkgs/nixos/lib/eval-config.nix> {
      inherit system;
      modules = [ ./modules ];
    };
    inherit (eval.options.nixcloud) webservices;
  in lib.attrNames (lib.filterAttrs (lib.const lib.isOption) webservices);

in lib.genAttrs availableWS mkRunner
