-- Disable text wrapping
vim.opt.wrap = false

-- Keep wrapped lines indented
vim.opt.breakindent = true

-- Wrap lines at words rather than the last character that fits
vim.opt.linebreak = true

-- Enable mouse support in all modes
vim.opt.mouse = "a"

-- Display line numbers
vim.opt.number = true

-- Hide the line and column number of the cursor position
vim.opt.ruler = false

-- Do not show the intro screen when opening without arguments
vim.opt.shortmess:append({ I = true })

-- Hide partial commands
vim.opt.showcmd = false

-- Open new splits below and to the right of current window
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Reduce time to execute 'CursorHold' autocommand
vim.opt.updatetime = 1000

-- Display whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Use case-insensitive searching unless uppercase letters are used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Autocorrect casing for completions
vim.opt.infercase = true

-- Display live preview of substitutions
vim.opt.inccommand = "split"

-- Default to indentation based folding
vim.opt.foldmethod = "indent"

-- Use treesitter for 'expr' foldmethod when enabled
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Display folded line normally with highlighting and no line wrapping
vim.opt.foldtext = ""

-- Keep all folds expanded by default
vim.opt.foldlevel = 99

-- Display popup menus for completions but don't insert without manual selection
vim.opt.completeopt = { "menu", "menuone", "noinsert", "popup", "fuzzy" }

-- Hide completion messages
vim.opt.shortmess:append({ c = true, C = true })

-- Insert spaces instead of tabs
vim.opt.expandtab = true

-- Use 2 spaces as default indentation
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Automatically indent when starting a new line
vim.opt.smartindent = true

-- Disable swapfiles
vim.opt.swapfile = false

-- Persist undo history to a file
vim.opt.undofile = true

-- Disable creation of backups before overwriting a file
vim.opt.writebackup = false

-- Save local options in sessions
vim.opt.sessionoptions:append("localoptions")
