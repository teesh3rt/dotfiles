{ inputs, ... }:

{
  flake.modules.nixos.server = { pkgs, config, ... }: {
    imports = [
      inputs.copyparty.nixosModules.default
    ];

    sops.secrets."copyparty/passwords/ilay" = {
      owner = config.services.copyparty.user;
    };
    sops.secrets."copyparty/passwords/ron" = {
      owner = config.services.copyparty.user;
    };

    nixpkgs.overlays = [ inputs.copyparty.overlays.default ];
    environment.systemPackages = [ pkgs.copyparty ];
    services.copyparty = {
      enable = true;
      settings = {
        i = "0.0.0.0";
        p = [ 3293 ];

        e2d = true;
        e2t = true;
        shr = "/shr";
      };
      accounts = {
        ilay.passwordFile = config.sops.secrets."copyparty/passwords/ilay".path;
        ron.passwordFile = config.sops.secrets."copyparty/passwords/ron".path;
      };
      volumes = {
        "/" = {
          path = "/var/lib/copyparty/data";
          access = {
            rwmd = [ "ilay" ];
            r = [ "ron" ];
          };
        };
        "/ilay" = {
          path = "/var/lib/copyparty/data/ilay";
          access = {
            rwmd = [ "ilay" ];
          };
        };
        "/ron" = {
          path = "/var/lib/copyparty/data/ron";
          access = {
            rwmd = [ "ron" ];
          };
        };
      };
    };
  };
}
