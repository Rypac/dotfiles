vim.api.nvim_create_user_command("Lazygit", function(opts)
  if opts.args then
    vim.cmd("terminal lazygit " .. opts.args)
  else
    vim.cmd("terminal lazygit")
  end
end, {
  desc = "Open lazygit in a terminal",
  nargs = "*",
})

vim.api.nvim_create_autocmd("TermClose", {
  desc = "Clear terminal on exiting Lazygit",
  pattern = "term://*lazygit*",
  group = vim.api.nvim_create_augroup("QuitLazygit", { clear = true }),
  callback = function(args)
    vim.cmd("bdelete! " .. args.buf)
  end,
})
