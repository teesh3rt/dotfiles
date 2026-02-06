{inputs, ...}: {
  flake.modules.nixos.base = {pkgs, ...}: {
    environment.systemPackages = [pkgs.neovim pkgs.statix];

    programs.neovim.enable = true;
    programs.neovim.defaultEditor = true;
  };

  flake.modules.homeManager.base = {
    imports = [inputs.lazyvim.homeManagerModules.default];

    programs.neovim.enable = true;
    programs.neovim.defaultEditor = true;

    programs.lazyvim = {
      enable = true;
      pluginSource = "nixpkgs";
      plugins.catppuccin = ''
        return { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } }
      '';
      plugins.neogit = ''
        return { "NeogitOrg/neogit", opts = {}, keys = { { "<leader>gg", "<cmd>Neogit<cr>" } } }
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
