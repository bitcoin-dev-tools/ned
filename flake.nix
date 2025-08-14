{
  description = "Standalone Neovim configuration with nvf";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    flake-utils,
    nvf,
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
            })
          ];
        }).neovim;
      formatter = pkgs.alejandra;
    });
}
