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
        "_" = ["trim_whitespace"]; # If no other formatter specified
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
      notify_on_error = true;
      notify_no_formatters = true;
      formatters = {
        alejandra = {
          command = "${pkgs.alejandra}/bin/alejandra";
          stdin = true;
          args = ["-"];
        };
        mdformat = {
          command = "${pkgs.mdformat}/bin/mdformat";
          stdin = true;
          args = ["-"];
        };
        shfmt = {
          prepend_args = ["-i" "2"];
          stdin = true;
        };
        stylua = {
          command = "${pkgs.stylua}/bin/stylua";
          stdin = true;
          args = ["-"];
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
