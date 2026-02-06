{...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: {
    environment.systemPackages = [pkgs.telegram-desktop];
  };
}
