{ self, ... }:

{
  flake.modules.nixos.desktop = { pkgs, ... }: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    environment.systemPackages = [ self.packages.${system}.u2c ];
  };
}
