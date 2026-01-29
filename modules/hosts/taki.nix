{ config, ... }:

{
  flake.modules.nixos.taki.imports = with config.flake.modules.nixos; [
    base
    desktop
  ];

  flake.modules.homeManager.taki.imports = with config.flake.modules.homeManager; [
    base
    desktop
  ];
}
