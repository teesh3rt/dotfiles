{ config, ... }:

{
  flake.modules.nixos.base = { pkgs, ... }: {
    programs.fish.enable = true;
    users.users.${config.flake.meta.user.name}.shell = pkgs.fish;
  };

  flake.modules.homeManager.base = {
    programs.fish = {
      enable = true;
    };

    programs.starship.enableFishIntegration = true;
  };
}
