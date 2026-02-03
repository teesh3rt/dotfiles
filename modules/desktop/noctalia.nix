{ config, inputs, ... }:

{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  # taki is a laptop, therefore it has a battery,
  # therefore noctalia should be able to detect it.
  #
  # we're using dendritic so its fine to modify configs in a file
  # in fact, its even encouraged!
  flake.modules.nixos.taki = {
    services.upower.enable = true;
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
              { id = "KeyboardLayout"; }
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
