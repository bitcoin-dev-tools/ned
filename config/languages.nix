{pkgs}: {
  # Defaults for all enabled languages
  enableTreesitter = true;
  enableFormat = false;

  clang = {
    enable = true;
  };

  nix = {
    enable = true;
    extraDiagnostics.enable = true;
  };

  python = {
    treesitter.enable = true;
  };

  rust = {
    enable = true;
  };
}
