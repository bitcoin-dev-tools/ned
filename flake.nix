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
                lsp.enable = true;
                theme.enable = true;
                treesitter.enable = true;
              };
            }
          ];
        }).neovim;
      formatter = pkgs.alejandra;
    });
}
