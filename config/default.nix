{
  pkgs,
  lib,
}: {
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
      lsp = {
        enable = true;
        servers = {
          "*" = {
            root_markers = [".git"];
            capabilities = {
              textDocument = {
                semanticTokens = {
                  multilineTokenSupport = true;
                };
              };
            };
          };
          "basedpyright" = {
            cmd = ["${pkgs.basedpyright}/bin/basedpyright-langserver" "--stdio"];
            root_markers = [
              ".git"
              "Pipfile"
              "pyproject.toml"
              "pyrightconfig.json"
              "requirements.txt"
              "setup.cfg"
              "setup.py"
            ];
            filetypes = ["python"];

            single_file_support = true;
            settings = {
              basedpyright = {
                analysis = {
                  autoSearchPaths = true;
                  disableOrganizeImports = true; # Use Ruff's import organiser
                  diagnosticMode = "openFilesOnly";
                  typeCheckingMode = "off"; # or "basic" for less strict checking
                  useLibraryCodeForTypes = false; # disable library type analysis
                };
              };
              python = {
                analysis = {
                  ignore = ["*"]; # Ignore all files for analysis to exclusively use Ruff for linting
                };
              };
            };
          };
        };
      };
      lsp.inlayHints.enable = true;
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
      treesitter = {
        enable = true;
        highlight.disable = lib.generators.mkLuaInline "
          -- Disable slow treesitter highlight for large files
          function(lang, buf)
            local max_filesize = 1000 * 1024 -- 1MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
          end
          ";
      };
      visuals = {
        fidget-nvim.enable = true;
        nvim-web-devicons.enable = true;
      };
    }
    // (import ./conform.nix).config.vim // (import ./snacks.nix).config.vim;
}
