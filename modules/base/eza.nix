{ ... }:

{
  flake.modules.nixos.base = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.eza ];
    environment.shellAliases = {
      "ls" = "${pkgs.eza}/bin/eza -lah --sort=type --icons=auto";
    };
  };

  flake.modules.homeManager.base = {
    programs.eza.enable = true;
  };
}
