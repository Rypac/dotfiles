vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Use a transparent background",
  group = vim.api.nvim_create_augroup("TransparentBackground", { clear = true }),
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { ctermbg = "NONE", bg = "NONE" })
  end,
})

vim.cmd("colorscheme iceberg")
