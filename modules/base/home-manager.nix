{ inputs, config, ... }:

{
  flake.modules.nixos.base = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.${config.flake.meta.user.name} = {
      home.stateVersion = config.flake.meta.stateVersion;
    };
  };
}
