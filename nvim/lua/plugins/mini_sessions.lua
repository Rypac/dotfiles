require("mini.sessions").setup()

vim.keymap.set("n", "<Leader>S", "<Cmd>lua MiniSessions.select()<CR>", { desc = "Select session" })
