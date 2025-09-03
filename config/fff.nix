{
  pkgs,
  fff-nvim-pkg,
  ...
}: {
  config.vim = {
    lazy.plugins = {
      "fff.nvim" = {
        package = fff-nvim-pkg;
        setupModule = "fff";
        setupOpts = {
          keymaps = {
            move_up = ["<Up>" "<C-p>" "<C-k>"];
            move_down = ["<Down>" "<C-n>" "<C-j>"];
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
