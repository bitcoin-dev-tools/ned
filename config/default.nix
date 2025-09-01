{
  pkgs,
  lib,
}: {
  config.vim =
    lib.recursiveUpdate
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
      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false; # throws an annoying debug message
      };
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
          "nil_ls" = {
            cmd = ["${pkgs.nil}/bin/nil"];
            filetypes = ["nix"];
            root_markers = ["flake.nix" ".git"];
            single_file_support = true;
          };
          "ruff" = {
            cmd = ["${pkgs.ruff}/bin/ruff" "server"];
            filetypes = ["python"];
            root_markers = [
              ".git"
              "Pipfile"
              "pyproject.toml"
              "pyrightconfig.json"
              "requirements.txt"
              "ruff.toml"
              "setup.cfg"
              "setup.py"
            ];
            single_file_support = true;
            capabilities = {
              textDocument = {
                hoverProvider = false;
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
      augroups = [
        {name = "LSP";}
        {name = "UserEvents";}
      ];
      autocmds = [
        {
          event = ["LspAttach"];
          group = "LSP";
          desc = "Configure LSP keymaps";
          callback = lib.generators.mkLuaInline ''
            function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client then
                  vim.keymap.set("n", "<leader>d", function()
                    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
                  end)
                  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
                  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
                  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Do[K]umentation" })
                  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Do[K]umentation" })
                end
            end
          '';
        }
        {
          event = ["BufReadPost"];
          group = "UserEvents";
          desc = "Resume last known cursor position";
          callback = lib.generators.mkLuaInline ''
            function(args)
              local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) <= vim.fn.line('$')
              local ignore_filetypes = { "gitcommit", "gitrebase", "svn", "hgcommit" }
              local filetype = vim.bo[args.buf].filetype
              local should_ignore = vim.tbl_contains(ignore_filetypes, filetype)

              if valid_line and not should_ignore then
                vim.cmd([[normal! g`"]])
              end
            end
          '';
        }
      ];
      statusline.lualine = {
        enable = true;
        theme = "auto";
      };
      theme = {
        enable = true;
        name = "catppuccin";
        style = "macchiato";
      };
      treesitter = {
        enable = true;
        indent.disable = ["nix"];
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
      lazy.plugins = {
        "nvim-surround" = {
          package = pkgs.vimPlugins.nvim-surround;
          setupModule = "nvim-surround";
          setupOpts = {};
          event = ["BufRead" "BufNewFile"];
        };
      };
      utility = {
        diffview-nvim.enable = true;
      };
      visuals = {
        fidget-nvim.enable = true;
        nvim-web-devicons.enable = true;
      };
    }
    (
      lib.recursiveUpdate
      (import ./conform.nix {inherit pkgs;}).config.vim
      (
        lib.recursiveUpdate
        (import ./snacks.nix).config.vim
        (import ./fff.nix {inherit pkgs;}).config.vim
      )
    );
}
