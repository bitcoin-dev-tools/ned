{pkgs}: {
  # Defaults for all enabled languages
  enableTreesitter = true;
  enableFormat = false;

  clang = {
    enable = true;
    lsp.enable = true;
  };

  nix = {
    enable = true;
    lsp.enable = true;
    lsp.package = pkgs.nil;
  };

  python = {
    treesitter.enable = true;
  };

  rust = {
    enable = true;
    lsp.enable = true;
  };
}
