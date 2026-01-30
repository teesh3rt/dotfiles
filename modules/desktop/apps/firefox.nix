{ inputs, config, ... }:

{
  flake.modules.nixos.desktop = {
    programs.firefox.enable = true;
  };

  flake.modules.homeManager.desktop = { pkgs, ... }: let
    system = pkgs.stdenv.hostPlatform.system;
    ff-addons = inputs.firefox-addons.packages.${system};
  in {
    programs.firefox = {
      enable = true;
      profiles.${config.flake.meta.user.name} = {
        extensions.packages = with ff-addons; [
          ublock-origin
          sponsorblock
          bitwarden
          darkreader
          youtube-shorts-block
        ];
      };
    };
  };
}
