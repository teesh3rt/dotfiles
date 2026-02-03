{ ... }:

{
  flake.modules.nixos.server = {
    services.cloudflared.enable = true;
  };
}
