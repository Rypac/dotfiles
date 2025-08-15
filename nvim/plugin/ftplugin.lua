vim.api.nvim_create_user_command("Ftplugin", function(opts)
  local filetype = opts.args ~= "" and opts.args or vim.bo.filetype
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/after/ftplugin/" .. filetype .. ".lua")
end, {
  desc = "Edit configuration for the current filetype",
  nargs = "?",
  complete = "filetype",
})

vim.keymap.set(
  "n",
  "<Leader>.",
  "<Cmd>Ftplugin<CR>",
  { desc = "Edit ftplugin for buffer filetype" }
)
