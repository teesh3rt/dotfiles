{ inputs, ... }:

{
  flake.modules.nixos.server = { pkgs, config, ... }: {
    imports = [
      inputs.copyparty.nixosModules.default
    ];

    sops.secrets."copyparty/passwords/teesh" = {
      owner = config.services.copyparty.user;
    };

    nixpkgs.overlays = [ inputs.copyparty.overlays.default ];
    environment.systemPackages = [ pkgs.copyparty ];
    services.copyparty = {
      enable = true;
      settings = {
        i = "0.0.0.0";
        p = [ 3293 ];
      };
      accounts = {
        teesh.passwordFile = config.sops.secrets."copyparty/passwords/teesh".path;
      };
      volumes = {
        "/" = {
          path = "/var/lib/copyparty/data"; # the default path
          access = {
            rwmda = [ "teesh" ];
          };
          flags = {
            e2d = true;
            e2t = true;
          };
        };
      };
    };
  };
}
