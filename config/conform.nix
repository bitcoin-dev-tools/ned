{pkgs}: {
  config.vim.formatter.conform-nvim = {
    enable = true;
    setupOpts = {
      formatters_by_ft = {
        bash = ["shfmt" "shellcheck"];
        c = ["clang_format"];
        cpp = ["clang_format"];
        fish = ["fish_indent"];
        go = ["gofmt"];
        lua = ["stylua"];
        markdown = ["mdformat"];
        nix = ["alejandra"];
        python = ["ruff_format"];
        rust = ["rustfmt"];
        sh = ["shfmt" "shellcheck"];
        yaml = ["yamlfmt"];
        "*" = ["codespell"];
        "_" = ["trim_whitespace"];
      };
      format_on_save = {
        _type = "lua-inline";
        expr = ''
          function(bufnr)
            local filetypes = { "rust" }
            if not vim.tbl_contains(filetypes, vim.bo[bufnr].filetype) then
              return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
          end
        '';
      };
      formatters = {
        alejandra = {
          command = "${pkgs.alejandra}/bin/alejandra";
        };
        codespell = {
          command = "${pkgs.codespell}/bin/codespell";
        };
        mdformat = {
          command = "${pkgs.mdformat}/bin/mdformat";
        };
        shfmt = {
          prepend_args = ["-i" "2"];
        };
        stylua = {
          command = "${pkgs.stylua}/bin/stylua";
        };
      };
    };
  };
  config.vim.luaConfigRC.conform-setup = ''
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
    })
    vim.api.nvim_set_keymap("", "<leader>f", "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<cr>", { desc = "Format buffer", noremap = true, silent = true })
  '';
}
