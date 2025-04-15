vim.diagnostic.config({
  virtual_text = true,
})

vim.keymap.set("n", "<Leader>k", vim.diagnostic.open_float, { desc = "Open diagnostic in float" })
