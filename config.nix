{pkgs}: {
  config.vim =
    {
      autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
        setupOpts = {
          fuzzy.implementation = "prefer_rust_with_warning";
          sources.default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
            "omni"
            "cmdline"
          ];
        };
      };
      binds.whichKey.enable = true;
      enableLuaLoader = true;
      git.enable = true;
      languages = import ./languages.nix {inherit pkgs;};
      lsp.enable = true;
      # Vim globals
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };
      # Vim options
      options = import ./options.nix {inherit (pkgs) lib;};
      keymaps = [
        {
          key = "<Space>";
          mode = ["n" "v"];
          action = "<Nop>";
          desc = "Disable space key";
        }
      ];
      statusline.lualine = {
        enable = true;
        theme = "auto";
      };
      theme.enable = true;
      treesitter.enable = true;
      visuals.fidget-nvim.enable = true;
      visuals.nvim-web-devicons.enable = true;
    }
    // (import ./conform.nix).config.vim // (import ./snacks.nix).config.vim;
}
