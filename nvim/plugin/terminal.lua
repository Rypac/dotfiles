vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Configure UI for builtin terminal",
  group = vim.api.nvim_create_augroup("UserConfigureTerminal", { clear = true }),
  callback = vim.schedule_wrap(function()
    vim.wo.number = false
    vim.wo.signcolumn = "no"
    vim.cmd("startinsert!")
  end),
})
