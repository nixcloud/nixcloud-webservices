{ lib }:

{
  stateDir = "/var/lib/nixcloud/TLS";

  # to prevent accidentally exceeding the ACME's rate limit (API) we hash the
  # option definitions in a way that the order of the 'inputs' as domains,
  # extraDomains and API endpoint don't affect the generated certificate
  hashACMEConfig = cfg: let
    server = cfg.acmeApiEndpoint;
    h = lib.fold (el: c: c // { ${el} = ""; }) {} ([ cfg.domain ] ++ cfg.extraDomains ++ [ server ]);
  in
    builtins.hashString "sha256" (builtins.toJSON h);
}
