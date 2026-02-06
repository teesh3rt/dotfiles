{...}: {
  flake.modules.nixos.base = {pkgs, ...}: {
    environment.systemPackages = [pkgs.gh];
  };

  flake.modules.homeManager.base = {
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
