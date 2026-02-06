{config, ...}: {
  flake.modules.nixos.base = {
    users.users.${config.flake.meta.user.name} = {
      isNormalUser = true;
      description = "${config.flake.meta.user.name}";
      extraGroups = ["networkmanager" "wheel"];
      packages = [];
    };
  };
}
