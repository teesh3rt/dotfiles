{config, ...}: {
  flake.modules.nixos.server = {
    services.soju.enable = true;
    services.soju.listen = [
      "irc+insecure://0.0.0.0:6667"
    ];

    # we may not use this in the configuration, however
    # we still declare this for the sysadmin to then go and
    # create the user using:
    #
    # sojuctl user create -name ${config.flake.meta.user.name} -password $(cat /run/secrets/irc/password)
    # or whatever, i dont exactly remember the command
    sops.secrets."irc/password" = {
      owner = config.flake.meta.user.name;
    };
  };
}
