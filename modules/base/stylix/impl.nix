{
  inputs,
  lib,
  ...
}: {
  flake.modules.nixos.base = {pkgs, ...}: {
    imports = [inputs.stylix.nixosModules.stylix];

    stylix = {
      enable = true;
      image = ./wallpaper.jpeg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      polarity = "dark";
    };
  };
}
