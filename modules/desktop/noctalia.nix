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
              {
                id = "Battery";
                alwaysShowPercentage = true;
                warningThreshold = 20;
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
