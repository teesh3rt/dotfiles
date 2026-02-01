{ ... }:

{
  flake.modules.nixos.server = {
    services.soju.enable = true;
    services.soju.listen = [
      "irc+insecure://0.0.0.0:6667"
    ];
  };
}
