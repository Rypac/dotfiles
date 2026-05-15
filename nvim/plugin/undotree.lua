vim.cmd("packadd nvim.undotree")

vim.keymap.set("n", "<Leader>u", "<Cmd>Undotree<CR>", { desc = "Undotree" })
