{ config, pkgs, lib, ... }:

with lib;


# TODO: create service owner

# --------------START OF THE ACTUAL CONFIG----------------------------------

# When the user does not have any content yet, he or she should find a
# page that informs them what to do next. TODO: Not active yet.

# Configuration of this module aims to be extremely simple, which
# makes it easy to get started and allows this to be easily copied.
# This means that not everyone trying out this webservice is
# likely not have had a thorough read of the documentation. Also, if
# you use the default, you may not know the contrived location where
# you need to put your data.

let
    serviceName = "darkhttpd";

    placeholderInfo = pkgs.writeText "placeholder.html" ''
     <h1>Congratulations. Its working!</h1>
     <p>You have just created a webservice to serve up your static
        web content. You should copy your content here:</p>
      <p style="text-align: center">${config.staticDir}</p>
      <p>The documentation for this can be found at https://nixcloud.io</p>
  '';
in

{
  options = {
    staticDir = mkOption {
    type = types.path;
    default = config.stateDir;
      description = ''
        Serve static content from the directory specified. By default it is a
        dedicated (new) subdirectory under the state directory unique to
        your service instance. Obviously, you will have to get your content into
        that directory.
      '';
    };
    cloneDir = mkOption {
    type = types.bool;
    default = false;
      description = ''
        Serve the content from a cloned copy of the directory indicated by the user.
        The copy is created in a unique folder under /var/run/nixcloud/webservices
        aka the 'state directory'. Especially useful for tiny websites that want to
        keep the original content somewhere safe.
      '';
    };
    serviceOwner = mkOption {
    type = types.string;
    default = builtins.replaceStrings ["."] ["_"] config.proxyOptions.domain;
      description = ''
	The group that is to be given ownership across a set of
	services to allow access.  The default option is a derivation
	of the domain name under which the service will be run -- e.g.
	example_com (for some unknown reason dots cause problems in many
	cases). However the user may use any valid group name.
      '';
    };
    directoryListing = mkOption {
    default = false;
      description = ''
	If a folder you are serving does not contain a file named
	index.html, setting the flag directoryListing will instead
	list the files present in that folder. Note that this may in
	some cases expose undesired details from your system, and is
	therefore turned off by default.
      '';
    };
    log = mkOption {
    default = false;
      description = ''
        Whether to log any data about requests to the webserver,
	or not. If you are not going to use it, because you use
	some other mechanism (like Piwik) you might as well keep it
	turned off to save yourself disk wear and enhance user privacy.
      '';
    };
    logFile = mkOption {
    default = "/var/log/${serviceName}";
      description = ''
	Location of the file where the logs are stored. If you want
	to log anything that is.
      '';
    };
    serviceName = mkOption {
    default = serviceName;
    };
};

# Serving only on localhost for security purposes. The ports do not have to be
# reachable from the outside directly, as the static site will be proxied anyway.
# If you would want to serve on the actual IP address, use
# "${config.proxyOptions.ip}" instead of "127.0.0.1";

  meta = {
    description = "An efficient, very restricted service for serving up HTML";
    longDescription = ''
This is a simple and secure service for a static website using the
nixcloud webservice abstraction. A basic configuration.nix would
for example contain the following:

  nixcloud.webservices.darkhttpd = {
    foo.enable = true;
    foo.staticDir = "/path/to/statictest/";
    foo.proxyOptions.port = 8087;
    foo.proxyOptions.domain = "example.net";
  };

This would serve the HTML content in /path/to/statictest as a website on
http(s)://example.net, proxied from a local server listening on port 8087. If
you do not include the value for staticDir, you will be assigned a standard
location.

NOTE THAT /TMP IS NOT CONSIDERED A VALID LOCATION, AS A SEPARATE /TMP TEMPORARY
directory will be mounted (read-only) to isolate the server process from
anything else happening on the computer. While we are dealing with static HTML,
we don't know if the server needs temporary files in any way and by using a
separate temporary directory we protect from any potential data leaks resulting
from that.

There are some fancier options one can use, such as:

    foo.serviceOwner = "roman";
    foo.proxyOptions.TLS = "none";
    foo.proxyOptions.http.mode = "on";
    foo.proxyOptions.https.mode = "off";
    foo.proxyOptions.path = "/"; };

'';

    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ leenaars ];
    meta.platforms = lib.platforms.linux;
  };

   config = let
    serviceCommand = "${pkgs.${config.serviceName}}/bin/${serviceName}";
    serviceParameters = [
      "${toString config.staticDir}"
      "--addr" "127.0.0.1"
      "--port" "${toString config.proxyOptions.port}"
      "--no-server-id"
      "--daemon"
      "--no-keepalive"
      "--mimetypes" "${pkgs.apacheHttpd}/conf/mime.types"
    ] ++ optional (!config.directoryListing) "--no-listing"
      ++ optional (config.log) "--log ${config.logFile}";
  in mkIf config.enable rec {

# TODO WISHLIST: if the user flags that he wants to work with a fixed copy of
# the site a clone should be made. For tiny static sites, that could even be in
# the Nix store. This would allow rollbacks etc.

# TODO WISHLIST: We assume that the owner of domain name example.com may need
# to have access to all the assets from that domain, so that different services
# may be combined. For instance, a remote text editor instance such as Leaps
# without the strict access restriction we apply to this instance could be used
# to manually edit some static content served on a public facing website.
# Therefore group ownership is set to the value of serviceOwner as configured
# by the user. The user can also choose to make this a specific group of
# course.

# TODO WISHLIST: Allow a remote URI (e.g. git/darcs/mercurial repository or ZIP
# file) to be used; in case of a repository this could be polled at some
# interval chosen.

    groups."${config.serviceOwner}" = {};

    users."${config.serviceName}" = {
      description = "${config.serviceName} server user for ${config.serviceOwner}";
      home        = config.staticDir;
      createHome  = false;
      group = config.serviceOwner;
    };

    systemd.services."${config.serviceName}" = {
      description   = "${config.serviceName} service created by Nixcloud";
      wantedBy      = [ "multi-user.target" ];
      after         = [ "network.target" ];

      serviceConfig = {
        User = "${config.serviceName}";
        Group = "${config.serviceOwner}";
        Restart = "always";
        WorkingDirectory = config.stateDir;
	MemoryDenyWriteExecute = true;
	RestrictNameSpaces = true;
	NoNewPrivileges = true;
	ProtectHome = true;
	PrivateUsers = true;
	ProtectSystem = true;
        PrivateTmp = true;
	ProtectKernelTunables = true;
	LogsDirectory = config.logFile;
	Type = "forking";
        ExecStart = lib.concatMapStringsSep " " lib.escapeShellArg ([serviceCommand] ++ serviceParameters );
      };
    };
  };
}
