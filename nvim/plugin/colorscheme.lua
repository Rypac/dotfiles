vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Use a transparent background",
  group = vim.api.nvim_create_augroup("TransparentBackground", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.env.TERM_PROGRAM == "Apple_Terminal" then
      vim.api.nvim_set_hl(0, "Normal", { ctermbg = "NONE", bg = "NONE" })
    end
  end,
})

vim.cmd("colorscheme iceberg")
