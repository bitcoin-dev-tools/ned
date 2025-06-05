{
  config.vim = {
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        bigfile = {enabled = true;};
        dim = {enabled = true;};
        explorer = {enabled = true;};
        indent = {enabled = true;};
        picker = {enabled = true;};
      };
    };
    keymaps = [
      # Zen Mode
      {
        key = "<leader>z";
        mode = ["n"];
        action = ":lua Snacks.zen()<CR>";
        desc = "Toggle Zen Mode";
      }
      {
        key = "<leader>Z";
        mode = ["n"];
        action = ":lua Snacks.zen.zoom()<CR>";
        desc = "Toggle Zoom";
      }
      # Top Pickers & Explorer
      {
        key = "<leader>sf";
        mode = ["n"];
        action = ":lua Snacks.picker.smart()<CR>";
        desc = "Smart Find Files";
      }
      {
        key = "<leader><space>";
        mode = ["n"];
        action = ":lua Snacks.picker.buffers()<CR>";
        desc = "Buffers";
      }
      {
        key = "<leader>/";
        mode = ["n"];
        action = ":lua Snacks.picker.grep()<CR>";
        desc = "Grep";
      }
      {
        key = "<leader>:";
        mode = ["n"];
        action = ":lua Snacks.picker.command_history()<CR>";
        desc = "Command History";
      }
      {
        key = "<leader>n";
        mode = ["n"];
        action = ":lua Snacks.picker.notifications()<CR>";
        desc = "Notification History";
      }
      {
        key = "<leader>e";
        mode = ["n"];
        action = ":lua Snacks.explorer()<CR>";
        desc = "File Explorer";
      }
      # Find
      {
        key = "<leader>fb";
        mode = ["n"];
        action = ":lua Snacks.picker.buffers()<CR>";
        desc = "Buffers";
      }
      {
        key = "<leader>fc";
        mode = ["n"];
        action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })";
        desc = "Find Config File";
      }
      {
        key = "<leader>ff";
        mode = ["n"];
        action = ":lua Snacks.picker.files()<CR>";
        desc = "Find Files";
      }
      {
        key = "<leader>fg";
        mode = ["n"];
        action = ":lua Snacks.picker.git_files()<CR>";
        desc = "Find Git Files";
      }
      {
        key = "<leader>fp";
        mode = ["n"];
        action = ":lua Snacks.picker.projects()<CR>";
        desc = "Projects";
      }
      {
        key = "<leader>fr";
        mode = ["n"];
        action = ":lua Snacks.picker.recent()<CR>";
        desc = "Recent";
      }
      # Git
      {
        key = "<leader>gb";
        mode = ["n"];
        action = ":lua Snacks.picker.git_branches()<CR>";
        desc = "Git Branches";
      }
      {
        key = "<leader>gl";
        mode = ["n"];
        action = ":lua Snacks.picker.git_log()<CR>";
        desc = "Git Log";
      }
      {
        key = "<leader>gL";
        mode = ["n"];
        action = ":lua Snacks.picker.git_log_line()<CR>";
        desc = "Git Log Line";
      }
      {
        key = "<leader>gs";
        mode = ["n"];
        action = ":lua Snacks.picker.git_status()<CR>";
        desc = "Git Status";
      }
      {
        key = "<leader>gS";
        mode = ["n"];
        action = ":lua Snacks.picker.git_stash()<CR>";
        desc = "Git Stash";
      }
      {
        key = "<leader>gd";
        mode = ["n"];
        action = ":lua Snacks.picker.git_diff()<CR>";
        desc = "Git Diff (Hunks)";
      }
      {
        key = "<leader>gf";
        mode = ["n"];
        action = ":lua Snacks.picker.git_log_file()<CR>";
        desc = "Git Log File";
      }
      # Grep
      {
        key = "<leader>sb";
        mode = ["n"];
        action = ":lua Snacks.picker.lines()<CR>";
        desc = "Buffer Lines";
      }
      {
        key = "<leader>sB";
        mode = ["n"];
        action = ":lua Snacks.picker.grep_buffers()<CR>";
        desc = "Grep Open Buffers";
      }
      {
        key = "<leader>sg";
        mode = ["n"];
        action = ":lua Snacks.picker.grep()<CR>";
        desc = "Grep";
      }
      {
        key = "<leader>sw";
        mode = ["n" "x"];
        action = ":lua Snacks.picker.grep_word()<CR>";
        desc = "Visual selection or word";
      }
      # Search
      {
        key = "<leader>s\"";
        mode = ["n"];
        action = ":lua Snacks.picker.registers()<CR>";
        desc = "Registers";
      }
      {
        key = "<leader>s/";
        mode = ["n"];
        action = ":lua Snacks.picker.search_history()<CR>";
        desc = "Search History";
      }
      {
        key = "<leader>sa";
        mode = ["n"];
        action = ":lua Snacks.picker.autocmds()<CR>";
        desc = "Autocmds";
      }
      {
        key = "<leader>sc";
        mode = ["n"];
        action = ":lua Snacks.picker.command_history()<CR>";
        desc = "Command History";
      }
      {
        key = "<leader>sC";
        mode = ["n"];
        action = ":lua Snacks.picker.commands()<CR>";
        desc = "Commands";
      }
      {
        key = "<leader>sd";
        mode = ["n"];
        action = ":lua Snacks.picker.diagnostics()<CR>";
        desc = "Diagnostics";
      }
      {
        key = "<leader>sD";
        mode = ["n"];
        action = ":lua Snacks.picker.diagnostics_buffer()<CR>";
        desc = "Buffer Diagnostics";
      }
      {
        key = "<leader>sh";
        mode = ["n"];
        action = ":lua Snacks.picker.help()<CR>";
        desc = "Help Pages";
      }
      {
        key = "<leader>sH";
        mode = ["n"];
        action = ":lua Snacks.picker.highlights()<CR>";
        desc = "Highlights";
      }
      {
        key = "<leader>si";
        mode = ["n"];
        action = ":lua Snacks.picker.icons()<CR>";
        desc = "Icons";
      }
      {
        key = "<leader>sj";
        mode = ["n"];
        action = ":lua Snacks.picker.jumps()<CR>";
        desc = "Jumps";
      }
      {
        key = "<leader>sk";
        mode = ["n"];
        action = ":lua Snacks.picker.keymaps()<CR>";
        desc = "Keymaps";
      }
      {
        key = "<leader>sl";
        mode = ["n"];
        action = ":lua Snacks.picker.loclist()<CR>";
        desc = "Location List";
      }
      {
        key = "<leader>sm";
        mode = ["n"];
        action = ":lua Snacks.picker.marks()<CR>";
        desc = "Marks";
      }
      {
        key = "<leader>sM";
        mode = ["n"];
        action = ":lua Snacks.picker.man()<CR>";
        desc = "Man Pages";
      }
      {
        key = "<leader>sp";
        mode = ["n"];
        action = ":lua Snacks.picker.lazy()<CR>";
        desc = "Search for Plugin Spec";
      }
      {
        key = "<leader>sq";
        mode = ["n"];
        action = ":lua Snacks.picker.qflist()<CR>";
        desc = "Quickfix List";
      }
      {
        key = "<leader>sR";
        mode = ["n"];
        action = ":lua Snacks.picker.resume()<CR>";
        desc = "Resume";
      }
      {
        key = "<leader>su";
        mode = ["n"];
        action = ":lua Snacks.picker.undo()<CR>";
        desc = "Undo History";
      }
      {
        key = "<leader>uC";
        mode = ["n"];
        action = ":lua Snacks.picker.colorschemes()<CR>";
        desc = "Colorschemes";
      }
      # LSP
      {
        key = "gd";
        mode = ["n"];
        action = ":lua Snacks.picker.lsp_definitions()<CR>";
        desc = "Goto Definition";
      }
      {
        key = "gD";
        mode = ["n"];
        action = ":lua Snacks.picker.lsp_declarations()<CR>";
        desc = "Goto Declaration";
      }
      {
        key = "gr";
        mode = ["n"];
        action = ":lua Snacks.picker.lsp_references()<CR>";
        desc = "References";
        nowait = true;
      }
      {
        key = "gI";
        mode = ["n"];
        action = ":lua Snacks.picker.lsp_implementations()<CR>";
        desc = "Goto Implementation";
      }
      {
        key = "gy";
        mode = ["n"];
        action = ":lua Snacks.picker.lsp_type_definitions()<CR>";
        desc = "Goto T[y]pe Definition";
      }
      {
        key = "<leader>ss";
        mode = ["n"];
        action = ":lua Snacks.picker.lsp_symbols()<CR>";
        desc = "LSP Symbols";
      }
      {
        key = "<leader>sS";
        mode = ["n"];
        action = ":lua Snacks.picker.lsp_workspace_symbols()<CR>";
        desc = "LSP Workspace Symbols";
      }
      # Toggles
      {
        key = "<leader>us";
        mode = ["n"];
        action = ":lua Snacks.toggle.option('spell', { name = 'Spelling' })";
        desc = "Toggle Spelling";
      }
      {
        key = "<leader>uw";
        mode = ["n"];
        action = ":lua Snacks.toggle.option('wrap', { name = 'Wrap' })";
        desc = "Toggle Wrap";
      }
      {
        key = "<leader>uL";
        mode = ["n"];
        action = ":lua Snacks.toggle.option('relativenumber', { name = 'Relative Number' })";
        desc = "Toggle Relative Number";
      }
      {
        key = "<leader>ud";
        mode = ["n"];
        action = ":lua Snacks.toggle.diagnostics()<CR>";
        desc = "Toggle Diagnostics";
      }
      {
        key = "<leader>ul";
        mode = ["n"];
        action = ":lua Snacks.toggle.line_number()<CR>";
        desc = "Toggle Line Number";
      }
      {
        key = "<leader>uc";
        mode = ["n"];
        action = ":lua Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })";
        desc = "Toggle Conceallevel";
      }
      {
        key = "<leader>uT";
        mode = ["n"];
        action = ":lua Snacks.toggle.treesitter()<CR>";
        desc = "Toggle Treesitter";
      }
      {
        key = "<leader>ub";
        mode = ["n"];
        action = ":lua Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' })";
        desc = "Toggle Dark Background";
      }
      {
        key = "<leader>uh";
        mode = ["n"];
        action = ":lua Snacks.toggle.inlay_hints()<CR>";
        desc = "Toggle Inlay Hints";
      }
      {
        key = "<leader>ug";
        mode = ["n"];
        action = ":lua Snacks.toggle.indent()<CR>";
        desc = "Toggle Indent";
      }
      {
        key = "<leader>uD";
        mode = ["n"];
        action = ":lua Snacks.toggle.dim()<CR>";
        desc = "Toggle Dim";
      }
    ];
  };
  # Disable the default lsp keybinds to avoid duplicates with snacks
  lsp = {
    mappings = {
      addWorkspaceFolder = null;
      codeAction = null;
      documentHighlight = null;
      format = null;
      goToDeclaration = null;
      goToDefinition = null;
      goToType = null;
      hover = null;
      listDocumentSymbols = null;
      listImplementations = null;
      listReferences = null;
      listWorkspaceFolders = null;
      listWorkspaceSymbols = null;
      nextDiagnostic = null;
      openDiagnosticFloat = null;
      previousDiagnostic = null;
      removeWorkspaceFolder = null;
      renameSymbol = null;
      signatureHelp = null;
      toggleFormatOnSave = null;
    };
  };
}
