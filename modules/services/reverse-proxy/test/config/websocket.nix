[ { 
  TLS = "ACME"; 
  domain = "example.ws"; 
  http = { mode = "on"; }; 
  https = { mode = "on"; };
  websockets = {
    ws = {
      subpath = "/ws";
      #https.basicAuth."nixclouduser" = "password_world_readable_in_nix_store";
      http.mode = "on";
    };
  };
  ip = "127.0.0.1";
  path = "/myapp"; 
  port = 8080;
  }
]
