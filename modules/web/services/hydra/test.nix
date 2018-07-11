let
  testRunner = ''
    import time
    import requests

    session = requests.session()
    session.headers.update({
      'referer': 'http://example.com/',
      'content-type': 'application/json',
    })

    session.post('http://example.com/login', json={
      'username': 'admin',
      'password': 'test',
    }).raise_for_status()

    session.put('http://example.com/project/test', json={
      'displayname': 'Test project',
      'enabled': 1,
    }).raise_for_status()

    session.put('http://example.com/jobset/test/foo', json={
      'nixexprpath': 'default.nix',
      'nixexprinput': 'testinput',
      'enabled': 1,
      'checkinterval': 100000,
      'inputs': {
        'testinput': {
          'type': 'git',
          'value': '/var/lib/hydra-test-jobset',
        },
      },
    }).raise_for_status()

    evals = []

    while len(evals) == 0:
      response = session.get('http://example.com/jobset/test/foo/evals')
      response.raise_for_status()
      evals = response.json()['evals']
      time.sleep(1)

    build_data = None

    while True:
      build = evals[0]['builds'][0]
      response = session.get('http://example.com/build/{}'.format(build))
      response.raise_for_status()
      build_data = response.json()
      if build_data['finished'] == 1:
        print(build)
        break
      time.sleep(1)

    assert build_data['job'] == 'testJob'
    assert build_data['nixname'] == 'test-job'
    assert build_data['buildstatus'] == 0
  '';

in {
  name = "hydra";

  machine = { pkgs, lib, ... }: {
    # We don't want to wait for the timeout on https://cache.nixos.org/.
    nix.binaryCaches = lib.mkForce [];
    nixcloud.reverse-proxy.enable = true;
    nixcloud.reverse-proxy.extendEtcHosts = true;
    nixcloud.webservices.hydra = {
      foo.enable = true;
      foo.initialAdminPassword = "test";
      foo.proxyOptions.TLS = "none";
      foo.proxyOptions.domain = "example.com";
      foo.proxyOptions.http.mode = "on";
      foo.proxyOptions.https.mode = "off";
      foo.proxyOptions.port = 8080;
    };
    virtualisation.memorySize = 1024;
    environment.systemPackages = let
      runner = pkgs.python3Packages.buildPythonApplication {
        name = "hydra-test-runner";
        propagatedBuildInputs = [ pkgs.python3Packages.requests ];
        src = pkgs.runCommand "hydra-test-runner-source" {
          inherit testRunner;
        } ''
          mkdir "$out"
          cat > "$out/setup.py" <<EOF
          from distutils.core import setup
          setup(name='hydra-test-runner', scripts=['hydra-test-runner'])
          EOF
          echo "#!/usr/bin/env python" > "$out/hydra-test-runner"
          echo -n "$testRunner" >> "$out/hydra-test-runner"
        '';
      };
    in lib.singleton runner;
    system.activationScripts.hydrajobset = let
      gitRepo = pkgs.runCommand "test-input" {
        nativeBuildInputs = [ pkgs.git ];
      } ''
        mkdir "$out"
        export HOME="$PWD"
        cd "$out"

        git init
        git config --global user.email "dummy@example.com"
        git config --global user.name dummy

        cat > default.nix <<EOF
        {
          testJob = derivation {
            name = "test-job";
            system = builtins.currentSystem;
            builder = ./builder.sh;
          };
        }
        EOF

        cat > builder.sh <<EOF
        #!/bin/sh
        echo hello world > "\$out"
        EOF
        chmod +x builder.sh

        git add .
        git commit -m initial
      '';
    in ''
      mkdir -p /var/lib
      cp -rd ${lib.escapeShellArg gitRepo} /var/lib/hydra-test-jobset
    '';
  };

  testScript = ''
    $machine->waitForUnit('multi-user.target');

    $machine->waitForOpenPort(80);
    $machine->waitForOpenPort(8080); # XXX: Should use socket activation!

    my $buildNo = $machine->succeed('hydra-test-runner');
    chomp $buildNo;

    $machine->succeed(
      "curl -o build.nar http://example.com/build/$buildNo/output/out",
      'xzgrep -qF "hello world" build.nar'
    );
  '';
}
