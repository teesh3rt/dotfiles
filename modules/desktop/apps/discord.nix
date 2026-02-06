{...}: {
  flake.modules.nixos.desktop = {pkgs, ...}: let
    discord = pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    };
  in {
    environment.systemPackages = [discord];
  };
}
