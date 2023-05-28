vim.g.mapleader = " "

-- Search and replace
vim.keymap.set("v", "<C-r>", [["hy:%s/\V<C-r>h//g<left><left>]], { desc = "Replace selected text" })

-- Buffers
vim.keymap.set("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "First buffer" })
vim.keymap.set("n", "<leader>bl", "<cmd>blast<cr>", { desc = "Last buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bPrevious<cr>", { desc = "Previous buffer" })

-- Tabs
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabfirst<cr>", { desc = "First tab" })
vim.keymap.set("n", "<leader>tl", "<cmd>tablast<cr>", { desc = "Last tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tN", "<cmd>tabnew<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
