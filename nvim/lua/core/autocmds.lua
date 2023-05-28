local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TermOpen", {
  desc = "Configure UI for builtin terminal",
  group = augroup("ConfigureTerminal", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
  end,
})
