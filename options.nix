{
        # Set highlight on search
        hlsearch = false;
        number = true;
        relativenumber = true; # Relative line numbers

        # Avoid text shifting when signs appear
        signcolumn = "yes";

        # Don't wrap unless we call :wrap
        wrap = false;

        # Split in sane ways
        splitbelow = true;
        splitright = true;

        # Tab settings
        expandtab = true;
        shiftwidth = 4;
        tabstop = 4;
        softtabstop = 4;

        shell = "bash";
        mouse = "a"; # Enable mouse mode

        # Recovery
        undofile = true; # Save undo history
        backup = true;

        # Case insensitive search unless /C or Captital in search
        ignorecase = true;
        smartcase = true;

        updatetime = 250; # Decrease update time
        conceallevel = 0; # Show `` in markdown files
        cursorline = true; # Highligh current line
        clipboard = "unnamedplus";

        # Show trailing whitespace
        listchars = "trail:~,tab:>-,nbsp:␣";
        list = true;

        laststatus = 3; # Unified status bar for all splits
        showmode = false; # We use lualine for this

        # Continue indentation on wrapped lines
        breakindent = true;
        linebreak = true;
        breakindentopt = "list:-1";
}
