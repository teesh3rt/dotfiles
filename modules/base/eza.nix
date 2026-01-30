{ ... }:

{
  flake.modules.nixos.base = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.eza ];
    environment.shellAliases = {
      "eza" = "${pkgs.eza}/bin/eza -lah --sort=type --icons=auto";
      "ls" = "${pkgs.eza}/bin/eza";
    };
  };

  flake.modules.homeManager.base = {
    programs.eza.enable = true;
  };
}
