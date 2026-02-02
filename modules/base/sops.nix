{ inputs, ... }:

{
  flake.modules.nixos.base = { pkgs, ... }: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    sops.defaultSopsFile = ../../secrets.yaml;
    sops.age = {
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    environment.systemPackages = with pkgs; [
      sops
      age
    ];
  };
}
