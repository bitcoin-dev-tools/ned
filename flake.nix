{
  description = "Standalone Neovim configuration with nvf";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nvf.url = "github:notashelf/nvf";
  };
  outputs = {
    nixpkgs,
    flake-utils,
    nvf,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      languages = {
        clang = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };
        nix = {
          enable = true;
          format.enable = true;
          lsp.enable = true;
          lsp.package = pkgs.nil;
          treesitter.enable = true;
        };
        python = {
          enable = true;
          lsp.enable = true;
          lsp.package = pkgs.basedpyright;
          treesitter.enable = true;
          format.enable = true;
          format.type = "ruff";
        };
        rust = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };
      };
    in {
      packages.default =
        (nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            {
              config.vim = {
                inherit languages;
                autocomplete.blink-cmp.enable = true;
                autocomplete.blink-cmp.friendly-snippets.enable = true;
                autocomplete.blink-cmp.setupOpts.sources.default = [
                  "lsp"
                  "path"
                  "snippets"
                  "buffer"
                  "omni"
                  "cmdline"
                ];
                autocomplete.blink-cmp.setupOpts.fuzzy.implementation = "prefer_rust_with_warning";
                enableLuaLoader = true; # Speed up plugin load time
                visuals.fidget-nvim.enable = true;
                git.gitsigns.enable = true;
                statusline.lualine.enable = true;
                lsp.enable = true;
                theme.enable = true;
                treesitter.enable = true;
                luaConfigRC.custom-options =
                  /*
                  lua
                  */
                  ''
                    -- Set highlight on search
                    vim.opt.hlsearch = false

                    -- Make line numbers default
                    vim.opt.number = true

                    -- Use relative numbers
                    vim.opt.relativenumber = true

                    -- Don't show less than 8 lines of context
                    -- vim.opt.scrolloff = 8

                    -- Always show sign column to avoid text shifting
                    vim.opt.signcolumn = "yes"

                    -- Don't wrap unless we call :wrap
                    vim.opt.wrap = false

                    -- Split in sane ways
                    vim.opt.splitbelow = true
                    vim.opt.splitright = true

                    -- Tab settings
                    vim.opt.expandtab = true
                    vim.opt.shiftwidth = 4
                    vim.opt.tabstop = 4
                    vim.opt.softtabstop = 4

                    -- Use bash as shell instead of fish
                    vim.opt.shell = os.getenv("BASH") or "bash"

                    -- Enable mouse mode
                    vim.opt.mouse = "a"

                    -- Enable break indent
                    vim.opt.breakindent = true

                    -- Save undo history
                    vim.opt.undofile = true

                    -- Case insensitive searching UNLESS /C or capital in search
                    vim.opt.ignorecase = true
                    vim.opt.smartcase = true

                    -- Decrease update time
                    vim.opt.updatetime = 250

                    -- Show `` in markdown files
                    vim.opt.conceallevel = 0

                    -- Highlight current line
                    vim.opt.cursorline = true

                    -- Use system clipboard
                    vim.opt.clipboard = "unnamedplus"

                    -- Show trailing whitespace
                    vim.opt.listchars = "trail:~,tab:>-,nbsp:␣"
                    vim.opt.list = true

                    -- Unified status bar for all splits
                    vim.opt.laststatus = 3

                    -- Don't show mode as we use status line
                    vim.opt.showmode = false

                    -- Continue indentation on wrapped lines
                    vim.opt.breakindent = true
                    vim.opt.linebreak = true
                    vim.opt.breakindentopt = "list:-1"

                    -- Set directories for swap, backup, and undo files
                    local data_dir = vim.fn.stdpath("data")
                    vim.opt.directory = data_dir .. "/swap//"
                    vim.opt.backupdir = data_dir .. "/backup//"
                    vim.opt.undodir = data_dir .. "/undo//"

                    -- Enable backup and undo options
                    vim.opt.backup = true
                    vim.opt.undofile = true
                  '';
              };
            }
          ];
        }).neovim;
      formatter = pkgs.alejandra;
    });
}
