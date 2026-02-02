{ inputs, ... }:

{
  flake.modules.nixos.desktop = { pkgs, ... }: let
    niri-unstable = inputs.niri-flake.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
  in {
    imports = [
      inputs.niri-flake.nixosModules.niri
    ];

    programs.niri.enable = true;
    programs.niri.package = niri-unstable;
    environment.systemPackages = with pkgs; [
      wl-clipboard
      wayland-utils
    ];
  };

  flake.modules.homeManager.desktop = { pkgs, lib, ... }: let
    noctalia-pkg = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    noctalia-shell = "${noctalia-pkg}/bin/noctalia-shell";
    ghostty = "${pkgs.ghostty}/bin/ghostty";
    playerctl = "${pkgs.playerctl}/bin/playerctl";
    noctalia = cmd: [ noctalia-shell "ipc" "call" ] ++ (pkgs.lib.splitString " " cmd);
    xws-unstable = inputs.niri-flake.packages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite-unstable;
  in {
    programs.niri.settings.xwayland-satellite.enable = true;
    programs.niri.settings.xwayland-satellite.path = lib.getExe xws-unstable;
    programs.niri.settings = {
      environment."NIXOS_OZONE_WL" = "1";
      prefer-no-csd = true;
      input.keyboard.numlock = true;
      layer-rules = [ {
        matches = [ { namespace = "^noctalia-overview*"; } ];
        place-within-backdrop = true;
      } ];
      binds = {
        "Mod+Shift+S".action.screenshot = [];
        "Mod+Shift+Q".action.spawn = noctalia "sessionMenu toggle";
        "Mod+N".action.spawn = noctalia "notifications toggleHistory";
        "Mod+Shift+N".action.spawn = noctalia "notifications clear";
        "Mod+M".action.spawn = noctalia "media toggle";

        "Mod+Return".action.spawn = ghostty;
        "Mod+D".action.spawn = noctalia "launcher toggle";
        "Mod+L".action.spawn = noctalia "lockScreen lock";

        "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
        "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
        "XF86AudioMute".action.spawn = noctalia "volume muteOutput";

        "XF86AudioPlay".action.spawn-sh = "${playerctl} play-pause";
        "XF86AudioStop".action.spawn-sh = "${playerctl} stop";
        "XF86AudioPrev".action.spawn-sh = "${playerctl} previous";
        "XF86AudioNext".action.spawn-sh = "${playerctl} next";

        "Mod+Q".action.close-window = [];

        "Mod+Left".action.focus-column-left = [];
        "Mod+Down".action.focus-workspace-down = [];
        "Mod+Up".action.focus-workspace-up = [];
        "Mod+Right".action.focus-column-right = [];

        "Mod+Ctrl+Down".action.move-window-down = [];
        "Mod+Ctrl+Up".action.move-window-up = [];

        "Mod+Shift+Left".action.move-column-left = [];
        "Mod+Shift+Down".action.move-column-to-workspace-down = [];
        "Mod+Shift+Up".action.move-column-to-workspace-up = [];
        "Mod+Shift+Right".action.move-column-right = [];

        "Mod+BracketLeft".action.consume-or-expel-window-left = [];
        "Mod+BracketRight".action.consume-or-expel-window-right = [];

        "Mod+Comma".action.consume-window-into-column = [];
        "Mod+Period".action.expel-window-from-column = [];

        "Mod+F".action.maximize-column = [];
        "Mod+P".action.expand-column-to-available-width = [];
        "Mod+Shift+F".action.fullscreen-window = [];

        "Mod+C".action.center-column = [];
        "Mod+Ctrl+C".action.center-visible-columns = [];

        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";

        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        "Mod+O".action.toggle-overview = [];
      };
      spawn-at-startup = [
        { command = [ noctalia-shell ]; }
      ];
      hotkey-overlay.skip-at-startup = true;
    };
  };
}
