{ ... }:

{
  flake.modules.nixos.desktop = {
    services.xserver.xkb = {
      layout = "us,il";
      options = "grp:win_space_toggle";
    };
  };
}
