{config, ...}: {
  flake.modules.nixos.base = {
    system.stateVersion = "${config.flake.meta.stateVersion}";
  };
}
