{inputs, ...} @ inp: let
  flk = inp.config.flake;
in {
  flake.modules.nixos.server = {
    pkgs,
    lib,
    config,
    ...
  }: {
    imports = [
      inputs.copyparty.nixosModules.default
    ];

    sops.secrets."copyparty/passwords/ilay" = {
      owner = config.services.copyparty.user;
    };
    sops.secrets."copyparty/passwords/ron" = {
      owner = config.services.copyparty.user;
    };
    sops.secrets."cloudflare/copyparty" = {};

    services.cloudflared.tunnels = lib.mkIf config.services.cloudflared.enable {
      "files" = {
        credentialsFile = "/run/secrets/cloudflare/copyparty";
        default = "http_status:404";
        ingress = {
          "files.${flk.meta.web.domain.domain}" = {
            service = "http://localhost:3293";
          };
        };
      };
    };

    nixpkgs.overlays = [inputs.copyparty.overlays.default];
    environment.systemPackages = [pkgs.copyparty];
    services.copyparty.settings.xff-hdr =
      if config.services.cloudflared.enable
      then "cf-connecting-ip"
      else null;
    services.copyparty.settings.rproxy =
      if config.services.cloudflared.enable
      then 1
      else null;
    services.copyparty = {
      enable = true;
      settings = {
        i = "0.0.0.0";
        p = [3293];

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
            rwmd = ["ilay"];
            r = ["ron"];
          };
        };
        "/ilay" = {
          path = "/var/lib/copyparty/data/ilay";
          access = {
            rwmd = ["ilay"];
          };
        };
        "/ron" = {
          path = "/var/lib/copyparty/data/ron";
          access = {
            rwmd = ["ron"];
          };
        };
      };
    };
  };
}
