{ config, ... }:

let
  userName = config.flake.meta.git.name or config.flake.meta.user.name or "";
  userEmail = config.flake.meta.git.email or config.flake.meta.user.email or "";
in
{
  flake.modules.nixos.base = {
    programs.git.enable = true;
  };

  flake.modules.homeManager.base = {
    programs.git = {
      enable = true;
      settings = {
        user.name = userName;
        user.email = userEmail;
        init.defaultBranch = "main";
      };
    };
  };
}
