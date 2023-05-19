vim.g.mapleader = " "

-- Silent copy/paste/delete
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste silently" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete silently" })

-- Option toggling
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
