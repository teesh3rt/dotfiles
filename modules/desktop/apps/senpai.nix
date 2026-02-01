{ ... }:

{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.senpai ];
  };

  flake.modules.homeManager.desktop = {
    programs.senpai = {
      enable = true;
      config = {
        address = "irc.libera.chat:6697";
        nickname = "teesh3rt";
      };
    };
  };
}
