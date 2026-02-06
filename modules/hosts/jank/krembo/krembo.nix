{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.krembo = inputs.nixpkgs.lib.nixosSystem {
    modules = with config.flake.modules; [
      nixos.krembo
    ];
  };
}
