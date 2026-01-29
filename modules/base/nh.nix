{ config, ... }:

{
  flake.modules.nixos.base = {
    programs.nh = {
      enable = true;
      flake = config.flake.meta.location;
    };
  };
}
