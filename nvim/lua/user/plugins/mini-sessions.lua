require("mini.sessions").setup()

vim.keymap.set("n", "<Leader>O", "<Cmd>lua MiniSessions.select()<CR>", { desc = "Select session" })
