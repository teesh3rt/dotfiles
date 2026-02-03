{ ... }:

{
  flake.modules.nixos.server = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.cloudflared ];

    services.cloudflared.enable = true;
  };
}
