{...}: {
  flake.modules.nixos.base = {pkgs, ...}: {
    programs.bat.enable = true;

    environment.shellAliases = {
      "cat" = "${pkgs.bat}/bin/bat";
    };
  };

  flake.modules.homeManager.base = {
    programs.bat.enable = true;
  };
}
