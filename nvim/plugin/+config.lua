-- Disable text wrapping
vim.o.wrap = false

-- Keep wrapped lines indented
vim.o.breakindent = true

-- Wrap lines at words rather than the last character that fits
vim.o.linebreak = true

-- Enable mouse support in all modes
vim.o.mouse = "a"

-- Display line numbers
vim.o.number = true

-- Hide the line and column number of the cursor position
vim.o.ruler = false

-- Do not show the intro screen when opening without arguments
vim.opt.shortmess:append({ I = true })

-- Hide partial commands
vim.o.showcmd = false

-- Open new splits below and to the right of current window
vim.o.splitbelow = true
vim.o.splitright = true

-- Reduce time to execute 'CursorHold' autocommand
vim.o.updatetime = 1000

-- Display whitespace characters
vim.o.list = true
vim.o.listchars = "tab:» ,trail:·,nbsp:␣"

-- Use case-insensitive searching unless uppercase letters are used
vim.o.ignorecase = true
vim.o.smartcase = true

-- Autocorrect casing for completions
vim.o.infercase = true

-- Display live preview of substitutions
vim.o.inccommand = "split"

-- Default to indentation based folding
vim.o.foldmethod = "indent"

-- Use treesitter for 'expr' foldmethod when enabled
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Display folded line normally with highlighting and no line wrapping
vim.o.foldtext = ""

-- Keep all folds expanded by default
vim.o.foldlevel = 99

-- Display popup menus for completions but don't insert without manual selection
vim.o.completeopt = "menuone,noselect,popup,fuzzy"

-- Hide completion messages
vim.opt.shortmess:append({ c = true, C = true })

-- Insert spaces instead of tabs
vim.o.expandtab = true

-- Use 2 spaces as default indentation
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- Automatically indent when starting a new line
vim.o.smartindent = true

-- Disable swapfiles
vim.o.swapfile = false

-- Persist undo history to a file
vim.o.undofile = true

-- Disable creation of backups before overwriting a file
vim.o.writebackup = false

-- Save local options in sessions
vim.opt.sessionoptions:append("localoptions")

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable LSP based autoformat on save
vim.g.lsp_autoformat = true
