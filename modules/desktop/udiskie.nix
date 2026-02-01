{ ... }:

{
  flake.modules.homeManager.desktop = {
    services.udiskie.enable = true;
    services.udiskie.notify = true;
  };
}
