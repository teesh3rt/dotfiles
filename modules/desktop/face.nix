{config, ...}: {
  flake.modules.homeManager.desktop = {
    home.file.".face".source = config.flake.meta.user.face;
  };
}
