{...}: {
  flake.modules.nixos.base = {
    programs.starship.enable = true;
  };

  flake.modules.homeManager.base = {
    programs.starship.enable = true;
  };
}
