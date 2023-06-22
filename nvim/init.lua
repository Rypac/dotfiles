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

-- Keybindings
vim.g.mapleader = " "

-- Search and replace
vim.keymap.set("v", "<C-r>", [["hy:%s/\V<C-r>h//g<left><left>]], { desc = "Replace selected text" })

-- Auto commands
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Configure UI for builtin terminal",
  group = vim.api.nvim_create_augroup("ConfigureTerminal", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
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
