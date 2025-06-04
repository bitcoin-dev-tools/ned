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
      git.gitsigns.enable = true;
      languages = import ./languages.nix {inherit pkgs;};
      lsp.enable = true;
      # Vim globals
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };
      # Vim options
      options = {
        hlsearch = false;
        number = true;
        relativenumber = true;
        signcolumn = "yes";
        wrap = false;
        splitbelow = true;
        splitright = true;
        expandtab = true;
        shiftwidth = 4;
        tabstop = 4;
        softtabstop = 4;
        shell = "bash";
        mouse = "a";
        breakindent = true;
        undofile = true;
        ignorecase = true;
        smartcase = true;
        updatetime = 250;
        conceallevel = 0;
        cursorline = true;
        clipboard = "unnamedplus";
        listchars = "trail:~,tab:>-,nbsp:␣";
        list = true;
        laststatus = 3;
        showmode = false;
        linebreak = true;
        breakindentopt = "list:-1";
        backup = true;
      };
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
