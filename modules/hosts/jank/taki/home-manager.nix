{config, ...}: {
  flake.modules.nixos.taki = {
    home-manager.users.${config.flake.meta.user.name}.imports = [config.flake.modules.homeManager.taki];
  };
}
