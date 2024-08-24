require("mini.sessions").setup()

vim.keymap.set("n", "<Leader>O", "<Cmd>lua require('mini.sessions').select()<CR>", {
  desc = "Select session",
})
