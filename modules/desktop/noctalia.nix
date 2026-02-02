{ config, inputs, ... }:

{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  flake.modules.homeManager.desktop = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      enable = true;
      settings = {
        location = {
          monthBeforeDay = false;
          name = "Tel Aviv, Israel";
        };
        general.avatarImage = config.flake.meta.user.face;
        wallpaper.overviewEnabled = true;
        bar = {
          # density = "compact";
          position = "left";
          widgets = {
            left = [
              { id = "ControlCenter"; useDistroLogo = true; }
              { id = "Network"; }
              { id = "Bluetooth"; }
            ];
            center = [
              { id = "Workspace"; hideUnoccupied = true; labelMode = "none"; }
            ];
            right = [
              { id = "Tray"; }
              {
                id = "Battery";
                alwaysShowPercentage = true;
              }
              {
                id = "Clock";
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
          };
        };
      };
    };
  };
}
