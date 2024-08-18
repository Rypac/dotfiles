vim.api.nvim_create_user_command("Lazygit", function(opts)
  if opts.args ~= "" then
    vim.cmd("terminal lazygit " .. opts.args)
  else
    vim.cmd("terminal lazygit")
  end
end, {
  desc = "Open lazygit in a terminal",
  nargs = "*",
  complete = function(arg, _, _)
    return vim.tbl_filter(function(name)
      return vim.startswith(name, arg)
    end, { "status", "branch", "log", "stash" })
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  desc = "Clear terminal on exiting Lazygit",
  pattern = "term://*lazygit*",
  group = vim.api.nvim_create_augroup("UserQuitLazygit", { clear = true }),
  callback = function(args)
    vim.cmd("bdelete! " .. args.buf)
  end,
})
