-- General
vim.cmd([[filetype plugin indent on]])

-- UI
vim.opt.breakindent = true
vim.opt.number = true
vim.opt.signcolumn = "number"
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Editing
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
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
