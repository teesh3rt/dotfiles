{ ... }:

{
  flake.modules.generic.neovim = {
    vim.autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
    };
  };
}
