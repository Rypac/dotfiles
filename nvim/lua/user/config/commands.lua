local command = vim.api.nvim_create_user_command

command("ReloadConfig", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^user") then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)

  vim.notify("Neovim configuration reloaded: " .. vim.env.MYVIMRC, vim.log.levels.INFO)
end, {
  desc = "Reload neovim configuration",
})

command("Ftplugin", function(opts)
  local filetype = opts.args ~= "" and opts.args or vim.bo.filetype
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/after/ftplugin/" .. filetype .. ".lua")
end, {
  desc = "Edit configuration for the current filetype",
  nargs = "?",
  complete = "filetype",
})
