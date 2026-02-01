{ config, ... }:

{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.halloy ];
  };

  flake.modules.homeManager.desktop = { lib, ... }: {
    programs.halloy = {
      enable = true;
      settings = {
        buffer.channel.topic = {
          enabled = true;
        };

        font.size = 20;

        servers.${config.flake.meta.irc.server.name} = {
          nickname = config.flake.meta.user.name;
          server = config.flake.meta.irc.server.addr;
          port = config.flake.meta.irc.server.port;
          use_tls = false;
          dangerously_accept_invalid_certs = true;

          sasl.plain =
            lib.mkIf (config.flake.meta.irc.server.isBouncer or false) {
              username = config.flake.meta.user.name;
              password = config.flake.meta.irc.password; # dont commit this yet, please use sops-nix
            };
        };

        buffer.chathistory = {
          infinite_scroll = true;
        };
      };
    };
  };
}
