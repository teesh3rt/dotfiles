{ inputs, config, ... }:

{
  flake.nixosConfigurations.taki = inputs.nixpkgs.lib.nixosSystem {
    modules = with config.flake.modules; [
      nixos.taki
    ];
  };
}
