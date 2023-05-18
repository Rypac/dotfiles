-- UI
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.number = true
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = false
vim.opt.wrap = false

-- Editing
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.tabstop = 2

-- Folding
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = "manual"

-- Backup
vim.opt.swapfile = false

-- Ignore
vim.opt.wildignore = { ".git/", "node_modules/" }

-- Keybindings
vim.g.mapleader = " "

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste silently" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete silently" })

vim.keymap.set("n", "<leader>ob", "<cmd>lua vim.o.bg = vim.o.bg == 'dark' and 'light' or 'dark'<cr>", { desc = "Toggle background colour" })
vim.keymap.set("n", "<leader>oc", "<cmd>setlocal invcursorline<cr>", { desc = "Toggle cursor line" })
vim.keymap.set("n", "<leader>oC", "<cmd>setlocal invcursorcolumn<cr>", { desc = "Toggle cursor column" })
vim.keymap.set("n", "<leader>oh", "<cmd>setlocal invhlsearch<cr>", { desc = "Toggle search highlight" })
vim.keymap.set("n", "<leader>oi", "<cmd>setlocal invignorecase<cr>", { desc = "Toggle ignore case" })
vim.keymap.set("n", "<leader>ol", "<cmd>setlocal invlinebreak<cr>", { desc = "Toggle line break" })
vim.keymap.set("n", "<leader>on", "<cmd>setlocal invnumber<cr>", { desc = "Toggle line numbers" })
vim.keymap.set("n", "<leader>or", "<cmd>setlocal invrelativenumber<cr>", { desc = "Toggle relative numbers" })
vim.keymap.set("n", "<leader>os", "<cmd>setlocal invspell<cr>", { desc = "Toggle spelling" })
vim.keymap.set("n", "<leader>ot", "<cmd>lua vim.o.showtabline = vim.o.showtabline == 1 and 2 or 1<cr>", { desc = "Toggle tab line" })
vim.keymap.set("n", "<leader>ow", "<cmd>setlocal invwrap<cr>", { desc = "Toggle line wrap" })

-- Highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Configure builtin terminal
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Start builtin terminal in Insert mode and configure UI",
  pattern = "*",
  callback = function()
    vim.cmd("startinsert")
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

require("lazy").setup("plugins")
