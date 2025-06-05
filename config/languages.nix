{pkgs}: {
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
}
