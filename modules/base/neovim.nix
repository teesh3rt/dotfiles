{inputs, ...}: {
  flake.modules.nixos.base = {pkgs, ...}: {
    environment.systemPackages = [pkgs.neovim pkgs.statix];

    programs.neovim.enable = true;
    programs.neovim.defaultEditor = true;
  };

  flake.modules.homeManager.base = {pkgs, ...}: {
    imports = [inputs.lazyvim.homeManagerModules.default];

    programs.neovim.enable = true;
    programs.neovim.defaultEditor = true;

    programs.lazyvim = {
      enable = true;
      pluginSource = "nixpkgs";
      extraPackages = with pkgs; [
        nixd
        alejandra
        statix
      ];
      plugins.catppuccin = ''
        return { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } }
      '';
      plugins.neogit = ''
        return { "NeogitOrg/neogit", opts = {}, keys = { { "<leader>gg", "<cmd>Neogit<cr>" } } }
      '';
      plugins.nix = ''
        return {
          {
            "stevearc/conform.nvim",
            opts = {
              formatters_by_ft = {
                nix = { "alejandra" },
              },
            },
          },
          {
            "neovim/nvim-lspconfig",
            opts = {
              servers = {
                nixd = {},
              },
            },
          },
          {
            "mfussenegger/nvim-lint",
            opts = {
              linters_by_ft = {
                nix = { "statix" },
              },
            },
          }
        }
      '';
      extras = {
        lang.nix = {
          enable = true;
          installDependencies = true;
        };

        lang.python = {
          enable = true;
          installDependencies = true;
        };

        # only reason we don't add `pkgs.claude-code` to base is because base is meant to be things for servers,
        # we do need neovim on the server but we don't need a clanker on there too!
        #
        # plus, it can fail gracefully - if cc is not installed, it simply does nothing
        ai.claudecode = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };
      };
    };
  };
}
