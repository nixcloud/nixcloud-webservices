[ { 
  domain = "example.com"; 
  http = { 
    mode = "on"; 
    basicAuth."foo" = "bar1";
  }; 
  https = { 
    mode = "on"; 
    basicAuth."foo" = "bar2";
  }; 
  ip = "127.0.0.1"; 
  path = "/basicauth"; 
  port = 60000; 
  }
]
