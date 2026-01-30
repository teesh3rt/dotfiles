{ ... }:

{
  flake.modules.generic.neovim = {
    vim.languages = {
      python.enable = true;
      rust.enable = true;
      nix.enable = true;
      clang.enable = true;
    };

    vim.lsp.enable = true;
  };
}
