{config, ...}: {
  flake.modules.nixos.krembo = {
    home-manager.users.${config.flake.meta.user.name}.imports = [config.flake.modules.homeManager.krembo];
  };
}
