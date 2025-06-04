{pkgs}: {
  config.vim =
    {
      languages = import ./languages.nix {inherit pkgs;};
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
      enableLuaLoader = true;
      git.gitsigns.enable = true;
      lsp.enable = true;
      luaConfigRC.custom-options = builtins.readFile ./options.lua;
      statusline.lualine.enable = true;
      theme.enable = true;
      treesitter.enable = true;
      visuals.fidget-nvim.enable = true;
    }
    // (import ./conform.nix).config.vim // (import ./snacks.nix).config.vim;
}
