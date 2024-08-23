if vim.g.loaded_user_git ~= nil then
  return
end
vim.g.loaded_user_git = 1

vim.api.nvim_create_user_command("Tig", function(opts)
  if opts.args ~= "" then
    vim.cmd("terminal tig " .. opts.args)
  else
    vim.cmd("terminal tig")
  end
end, {
  desc = "Open tig in a terminal",
  nargs = "*",
  complete = function(arg, _, _)
    return vim.tbl_filter(function(name)
      return vim.startswith(name, arg)
    end, { "show", "reflog", "blame", "grep", "refs", "stash", "status" })
  end,
})

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
  desc = "Clear terminal on exiting Lazygit or Tig",
  pattern = { "term://*lazygit*", "term://*tig*" },
  group = vim.api.nvim_create_augroup("UserQuitGitClient", { clear = true }),
  callback = function(args)
    vim.cmd("bdelete! " .. args.buf)
  end,
})
