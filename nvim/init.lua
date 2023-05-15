-- UI
vim.opt.breakindent = true
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
vim.opt.foldmethod = "indent"

-- Backup
vim.opt.swapfile = false

-- Ignore
vim.opt.wildignore = { ".git/", "node_modules/" }

-- Keybindings
vim.g.mapleader = " "

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste silently" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete silently" })

vim.keymap.set("n", "<leader>oc", "<cmd>set invcursorline<cr>", { desc = "Toggle cursor line" })
vim.keymap.set("n", "<leader>oh", "<cmd>set invhlsearch<cr>", { desc = "Toggle search highlight" })
vim.keymap.set("n", "<leader>ol", "<cmd>set invlinebreak<cr>", { desc = "Toggle line break" })
vim.keymap.set("n", "<leader>on", "<cmd>set invnumber<cr>", { desc = "Toggle line numbers" })
vim.keymap.set("n", "<leader>or", "<cmd>set invrelativenumber<cr>", { desc = "Toggle relative numbers" })
vim.keymap.set("n", "<leader>ot", "<cmd>set showtabline=2<cr>", { desc = "Show tab line" })
vim.keymap.set("n", "<leader>oT", "<cmd>set showtabline=1<cr>", { desc = "Hide tab line" })
vim.keymap.set("n", "<leader>ow", "<cmd>set invwrap<cr>", { desc = "Toggle line wrap" })

-- Highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
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
