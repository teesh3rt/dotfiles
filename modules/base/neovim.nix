{inputs, ...}: {
  flake.modules.nixos.base = {
    imports = [inputs.nvf.nixosModules.default];

    programs.nvf.enable = true;
    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    programs.nvf.settings = {
      vim.viAlias = true;
      vim.vimAlias = true;

      vim.autocomplete.blink-cmp.enable = true;
      vim.telescope.enable = true;
      vim.utility.sleuth.enable = true;
      vim.binds.whichKey.enable = true;
      vim.ui.noice.enable = true;
      vim.statusline.lualine.enable = true;
      vim.clipboard.enable = true;
      vim.clipboard.registers = "unnamedplus";

      vim.git.neogit.enable = true;
      vim.keymaps = [
        {
          key = "<leader>gg";
          mode = "n";
          silent = true;
          action = "<cmd>Neogit<cr>";
        }
      ];

      vim.dashboard.alpha.enable = true;

      vim.lsp.enable = true;
      vim.lsp.formatOnSave = true;
      vim.languages = {
        nix.enable = true;
        nix.lsp.servers = ["nixd"];
        rust.enable = true;
        ts.enable = true;

        enableTreesitter = true;
        enableFormat = true;
      };
    };
  };
}
