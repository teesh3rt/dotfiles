{ ... }:

{
  flake.modules.nixos.desktop = {
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
