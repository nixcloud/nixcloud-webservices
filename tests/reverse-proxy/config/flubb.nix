[ { 
  TLS = "ACME"; 
  #_module = { 
  #	args = { name = "proxyOptions"; }; check = true; 
  #}; 
  domain = "flubb.com"; 
#   http = { mode = ""; }; 
  https = { mode = "on"; };
  ip = "127.0.0.1"; 
  path = "/blog"; 
  port = 60000;
  }
]
