{...}: {
  flake.modules.nixos.taki = {
    networking.hostName = "taki";
  };
}
