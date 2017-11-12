[ { 
  TLS = "ACME"; 
  #_module = { 
  #	args = { name = "proxyOptions"; }; check = true; 
  #}; 
  domain = "example.com"; 
  http = { mode = "on"; }; 
  https = { mode = "on"; };
  ip = "127.0.0.1"; 
  path = "/wiki"; 
  port = 60000; 
  }
]
