vim.api.nvim_create_user_command("Format", function()
  local saved_view = vim.fn.winsaveview()
  vim.cmd("normal! gggqG")
  vim.fn.winrestview(saved_view)
end, {
  desc = "Format the current buffer",
})

vim.keymap.set("n", "g=", "<Cmd>Format<CR>", { desc = "Format buffer" })
