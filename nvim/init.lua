-- UI
vim.opt.breakindent = true
vim.opt.cursorline = false
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.ruler = false
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.termguicolors = vim.env.TERM_PROGRAM ~= "Apple_Terminal"

-- Editing
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Folding
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = "manual"
vim.opt.foldminlines = 0
vim.opt.foldtext = "getline(v:foldstart)"

-- General
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.wildignore = { ".git/", "node_modules/" }
vim.opt.writebackup = false

-- Keybindings
vim.g.mapleader = " "

-- Search and replace
vim.keymap.set("v", "<C-r>", [["hy:%s/\V<C-r>h//g<left><left>]], { desc = "Replace selected text" })

-- Auto commands
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Configure UI for builtin terminal",
  group = vim.api.nvim_create_augroup("ConfigureTerminal", { clear = true }),
  callback = function()
    vim.cmd("startinsert")
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = vim.api.nvim_create_augroup("HighlightYankedText", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

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

require("lazy").setup("plugins", {
  defaults = {
    lazy = true,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
