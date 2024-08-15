-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable LSP based autoformat on save
vim.g.autoformat = true

local opt = vim.opt

-- Disable text wrapping
opt.wrap = false

-- Keep wrapped lines indented
opt.breakindent = true

-- Wrap lines at words rather than the last character that fits
opt.linebreak = true

-- Enable mouse support in all modes
opt.mouse = "a"

-- Display line numbers
opt.number = true

-- Hide the line and column number of the cursor position
opt.ruler = false

-- Do not show the intro screen when opening without arguments
opt.shortmess:append({ I = true })

-- Hide partial commands
opt.showcmd = false

-- Open new splits below and to the right of current window
opt.splitbelow = true
opt.splitright = true

-- Reduce time to execute 'CursorHold' autocommand
opt.updatetime = 1000

-- Display whitespace characters
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Use case-insensitive searching unless uppercase letters are used
opt.ignorecase = true
opt.smartcase = true

-- Autocorrect casing for completions
opt.infercase = true

-- Display live preview of substitutions
opt.inccommand = "split"

-- Default to indentation based folding
opt.foldmethod = "indent"

-- Use treesitter for 'expr' foldmethod when enabled
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Display folded line normally with highlighting and no line wrapping
opt.foldtext = ""

-- Keep all folds expanded by default
opt.foldlevel = 99

-- Display popup menus for completions but don't insert without manual selection
opt.completeopt = { "menu", "menuone", "noinsert" }

-- Hide completion messages
opt.shortmess:append({ c = true, C = true })

-- Insert spaces instead of tabs
opt.expandtab = true

-- Use 2 spaces as default indentation
opt.shiftwidth = 2
opt.tabstop = 2

-- Automatically indent when starting a new line
opt.smartindent = true

-- Disable swapfiles
opt.swapfile = false

-- Persist undo history to a file
opt.undofile = true

-- Disable creation of backups before overwriting a file
opt.writebackup = false
