{ ... }:

{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.ghostty ]; 
  };

  flake.modules.homeManager.desktop = {
    programs.ghostty.enable = true;
  };
}
