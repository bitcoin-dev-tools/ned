{pkgs, ...}: let
  fff-rust-crate = pkgs.rustPlatform.buildRustPackage {
    pname = "fff-nvim";
    version = "0.1.0";

    src = pkgs.fetchFromGitHub {
      owner = "dmtrKovalenko";
      repo = "fff.nvim";
      rev = "main";
      sha256 = "08shssd9nc1d36sliylyjjq9j3yg2d61ffsb31vkiai3gsv2qy7x";
    };

    cargoHash = "sha256-D05CdIl8DMns0SMBbZCdxhos05MyyIODsD+xdR09e/g=";

    nativeBuildInputs = with pkgs; [pkg-config perl];
    buildInputs = with pkgs; [openssl];

    RUSTC_BOOTSTRAP = true;
    doCheck = false;
  };

  copy-dynamic-library =
    if pkgs.stdenv.isDarwin
    then "cp -vf ${fff-rust-crate}/lib/libfff_nvim.dylib target/release/libfff_nvim.dylib"
    else "cp -vf ${fff-rust-crate}/lib/libfff_nvim.so target/release/libfff_nvim.so";
in {
  config.vim = {
    lazy.plugins = {
      "fff.nvim" = {
        package = pkgs.vimUtils.buildVimPlugin {
          pname = "fff.nvim";
          version = "main";
          src = pkgs.fetchFromGitHub {
            owner = "dmtrKovalenko";
            repo = "fff.nvim";
            rev = "main";
            sha256 = "08shssd9nc1d36sliylyjjq9j3yg2d61ffsb31vkiai3gsv2qy7x";
          };

          patchPhase = ''
            set -eo pipefail
            mkdir -p target/release
            ${copy-dynamic-library}
            echo "Library copied to target/release/"
          '';
        };
        setupModule = "fff";
        setupOpts = {
          keymaps = {
            move_up = [ "<Up>" "<C-p>" "<C-k>" ];
            move_down = [ "<Down>" "<C-n>" "<C-j>" ];
          };
        };
        keys = [
          {
            key = "<leader>sf";
            mode = ["n"];
            action = ":lua require('fff').find_files()<CR>";
            desc = "Find Files (fff)";
          }
          {
            key = "<leader>fg";
            mode = ["n"];
            action = ":lua require('fff').find_in_git_root()<CR>";
            desc = "Find Git Files (fff)";
          }
        ];
      };
    };
  };
}
