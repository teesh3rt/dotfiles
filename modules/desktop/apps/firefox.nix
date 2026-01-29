{ ... }:

{
  flake.modules.nixos.desktop = {
    programs.firefox.enable = true;
  };

  flake.modules.homeManager.desktop = {
    programs.firefox.enable = true;
  };
}
