{ ... }:

{
  flake.modules.nixos.base = {
    programs.zoxide = {
      enable = true;
      
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableXonshIntegration = true;
    };

    environment.shellAliases = {
      "cd" = "z";
    };
  };
}
