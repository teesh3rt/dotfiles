{ ... }:

{
  flake.modules.generic.neovim = { pkgs, ... }: {
    vim.lazy.plugins.neogit = {
      package = pkgs.vimPlugins.neogit;

      setupModule = "neogit";
      setupOpts = {};

      keys = [
        { mode = "n"; key = "<leader>gg"; action = "<cmd>Neogit<cr>"; }
      ];
    };
  };
}
