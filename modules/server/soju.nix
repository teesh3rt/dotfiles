{ ... }:

{
  flake.modules.nixos.server = {
    services.soju.enable = true;
  };
}
