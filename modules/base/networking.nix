{...}: {
  flake.modules.nixos.base = {
    networking.networkmanager.enable = true;
    networking.firewall.enable = false;
  };
}
