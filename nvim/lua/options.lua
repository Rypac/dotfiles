-- UI
vim.opt.breakindent = true
vim.opt.cursorline = false
vim.opt.linebreak = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.ruler = false
vim.opt.shortmess:append({ I = true })
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true
vim.opt.wrap = false
vim.cmd('colorscheme retrobox')

-- Editing
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.infercase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

-- Completions
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess:append({ c = true, C = true })

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Folding
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'manual'
vim.opt.foldminlines = 0
vim.opt.foldtext = 'getline(v:foldstart)'

-- General
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.wildignore = { '.git/', '.build/', 'dist-newstyle/', 'node_modules/' }
vim.opt.writebackup = false
