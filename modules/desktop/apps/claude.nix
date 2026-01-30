{ ... }:

{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.claude-code ];
  };
}
