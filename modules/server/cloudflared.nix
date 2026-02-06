{config, ...}: {
  flake.modules.nixos.server = {pkgs, ...}: {
    environment.systemPackages = [pkgs.cloudflared];

    services.cloudflared.enable = config.flake.meta.web.domain.has;
  };
}
