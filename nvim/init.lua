-- UI
vim.opt.number = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tabs
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Whitespace
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

-- Ignore
vim.opt.wildignore = { ".git/", "node_modules/" }

-- Keybindings
vim.g.mapleader = " "

-- Plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
