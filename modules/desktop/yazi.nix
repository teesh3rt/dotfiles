{ ... }:

{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    programs.yazi.enable = true;

    environment.systemPackages = [ pkgs.mpv ];
  };

  flake.modules.homeManager.desktop = {
    programs.yazi = {
      enable = true;

      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
