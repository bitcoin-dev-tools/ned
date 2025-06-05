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
            cmd = ["basedpyright-langserver" "--stdio"];
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
      treesitter.enable = true;
      visuals = {
        fidget-nvim.enable = true;
        nvim-web-devicons.enable = true;
      };
    }
    // (import ./conform.nix).config.vim // (import ./snacks.nix).config.vim;
}
