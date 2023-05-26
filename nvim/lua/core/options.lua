-- UI
vim.opt.cursorline = false
vim.opt.termguicolors = vim.env.TERM_PROGRAM ~= "Apple_Terminal"

-- Editing
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Folding
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = "manual"
vim.opt.foldminlines = 0
vim.opt.foldtext = "getline(v:foldstart)"

-- General
vim.opt.swapfile = false
vim.opt.wildignore = { ".git/", "node_modules/" }
