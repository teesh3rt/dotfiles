{ ... }:

{
  flake.modules.nixos.desktop = {
    services.xserver.enable = true;
    services.desktopManager.gnome.enable = false;
  };
}
