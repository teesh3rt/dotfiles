{...} @ inp: let
  flk = inp.config.flake;
in {
  flake.modules.nixos.server = {
    lib,
    config,
    ...
  }: {
    sops.secrets."cloudflare/git" = {};

    services.cloudflared.tunnels = lib.mkIf config.services.cloudflared.enable {
      "git" = {
        credentialsFile = "/run/secrets/cloudflare/git";
        default = "http_status:404";
        ingress = {
          "git.${flk.meta.web.domain.domain}" = {
            service = "http://localhost:5675";
          };
        };
      };
    };

    services.forgejo = {
      enable = true;
      database.type = "postgres";
      lfs.enable = true;
      settings = {
        server = {
          DOMAIN = "git.${flk.meta.web.domain.domain}";
          ROOT_URL = "https://git.${flk.meta.web.domain.domain}/";
          HTTP_PORT = 5675;
        };
        actions = {
          ENABLED = true;
          DEFAULT_ACTIONS_URL = "github";
        };
        service.DISABLE_REGISTRATION = true;
      };
    };
  };
}
