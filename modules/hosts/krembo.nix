{ config, ... }:

{
  flake.modules.nixos.krembo.imports = with config.flake.modules.nixos; [
    base
    server
  ];

  flake.modules.homeManager.krembo.imports = with config.flake.modules.homeManager; [
    base
  ];
}
