-- UI
vim.opt.breakindent = true
vim.opt.cursorline = false
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.ruler = false
vim.opt.shortmess:append({ I = true })
vim.opt.showcmd = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.updatetime = 1000
vim.opt.wrap = false

-- Display whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Editing
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.infercase = true
vim.opt.smartcase = true

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99

-- Completions
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.opt.shortmess:append({ c = true, C = true })

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

-- General
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.writebackup = false
