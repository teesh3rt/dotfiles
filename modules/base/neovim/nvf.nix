{ inputs, config, ... }:

{
  flake.modules.nixos.base = {
    imports = [ inputs.nvf.nixosModules.default ];

    programs.nvf = {
      enable = true;
      settings = config.flake.modules.generic.neovim;
    };
  };
}
