{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "test-dns-library";
  buildInputs = [ pkgs.nix pkgs.jq ];

  NIX_PATH = "nixpkgs=${pkgs.path}:dns-lib=${./.}";

  buildCommand = ''
    export TEST_ROOT="$(pwd)/test-tmp"
    export NIX_CONF_DIR="$TEST_ROOT/etc"
    export NIX_DB_DIR="$TEST_ROOT/db"
    export NIX_LOCALSTATE_DIR="$TEST_ROOT/var"
    export NIX_STATE_DIR="$TEST_ROOT/var/nix"
    export NIX_STORE_DIR="$TEST_ROOT/store"
    nix-store --init

    test_output="$(
      nix-instantiate --eval --json --strict '<dns-lib/tests.nix>'
    )"

    eval "$(echo "$test_output" | jq -r '
      map(.name + ": expected '\'''" +
          (.expected | tostring) + "'\''' but got '\'''" +
          (.result | tostring) + "'\'''")
      | @sh "echo \(. | join("\n"))"
    ')"

    [ "$test_output" = '[]' ]
    touch $out
  '';
}
