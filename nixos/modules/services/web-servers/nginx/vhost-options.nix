# This file defines the options that can be used both for the Apache
# main server configuration, and for the virtual hosts.  (The latter
# has additional options that affect the web server as a whole, like
# the user/group to run under.)

{ config, lib }:

with lib;
{
  options = {
    serverName = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        Name of this virtual host. Defaults to attribute name in virtualHosts.
      '';
      example = "example.org";
    };

    serverAliases = mkOption {
      type = types.listOf types.str;
      default = [];
      example = ["www.example.org" "example.org"];
      description = ''
        Additional names of virtual hosts served by this virtual host configuration.
      '';
    };

    listen = mkOption {
      type = with types; listOf (submodule {
        options = {
          addr = mkOption { type = str; description = "IP address."; };
          port = mkOption { type = nullOr int; description = "Port number."; };
        };
      });
      default =
        [ { addr = "0.0.0.0"; port = null; } ]
        ++ optional config.networking.enableIPv6
          { addr = "[::]"; port = null; };
      example = [
        { addr = "195.154.1.1"; port = 443; }
        { addr = "192.168.1.2"; port = 443; }
      ];
      description = ''
        Listen addresses and ports for this virtual host.
        IPv6 addresses must be enclosed in square brackets.
        Setting the port to <literal>null</literal> defaults
        to 80 for http and 443 for https (i.e. when enableSSL is set).
      '';
    };

    enableACME = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to ask Let's Encrypt to sign a certificate for this vhost.";
    };

    acmeRoot = mkOption {
      type = types.str;
      default = "/var/lib/acme/acme-challenge";
      description = "Directory to store certificates and keys managed by the ACME service.";
    };

    acmeFallbackHost = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        Host which to proxy requests to if acme challenge is not found. Useful
        if you want multiple hosts to be able to verify the same domain name.
      '';
    };

    enableSSL = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable SSL (https) support.";
    };

    forceSSL = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to always redirect to https.";
    };

    sslCertificate = mkOption {
      type = types.path;
      example = "/var/host.cert";
      description = "Path to server SSL certificate.";
    };

    sslCertificateKey = mkOption {
      type = types.path;
      example = "/var/host.key";
      description = "Path to server SSL certificate key.";
    };

    root = mkOption {
      type = types.nullOr types.path;
      default = null;
      example = "/data/webserver/docs";
      description = ''
        The path of the web root directory.
      '';
    };

    default = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Makes this vhost the default.
      '';
    };

    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = ''
        These lines go to the end of the vhost verbatim.
      '';
    };

    globalRedirect = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = http://newserver.example.org/;
      description = ''
        If set, all requests for this host are redirected permanently to
        the given URL.
      '';
    };

    basicAuth = mkOption {
      type = types.attrsOf types.str;
      default = {};
      example = literalExample ''
        {
          user = "password";
        };
      '';
      description = ''
        Basic Auth protection for a vhost.

        WARNING: This is implemented to store the password in plain text in the
        nix store.
      '';
    };

    locations = mkOption {
      type = types.attrsOf (types.submodule (import ./location-options.nix {
        inherit lib;
      }));
      default = {};
      example = literalExample ''
        {
          "/" = {
            proxyPass = "http://localhost:3000";
          };
        };
      '';
      description = "Declarative location config";
    };
  };
}
