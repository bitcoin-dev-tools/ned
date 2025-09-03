{
  description = "Standalone Neovim configuration with nvf";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fff-nvim = {
      url = "github:dmtrKovalenko/fff.nvim";
    };
  };
  outputs = {
    nixpkgs,
    flake-utils,
    nvf,
    fff-nvim,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      packages.default =
        (nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            (import ./config {
              inherit pkgs;
              lib = pkgs.lib;
              fff-nvim-pkg = fff-nvim.packages.${system}.fff-nvim;
            })
          ];
        }).neovim;
      formatter = pkgs.alejandra;
    });
}
