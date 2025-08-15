vim.api.nvim_create_user_command("ApplyColorscheme", function(opts)
  vim.cmd("colorscheme " .. opts.args)

  if vim.env.TERM_PROGRAM == "Apple_Terminal" then
    require("mini.colors").get_colorscheme():add_cterm_attributes():add_terminal_colors():apply()
  end
end, {
  desc = "Apply colorscheme compatible with Terminal.app",
  nargs = "?",
  complete = "color",
})

vim.cmd("ApplyColorscheme iceberg")
