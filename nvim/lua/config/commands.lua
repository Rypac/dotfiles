local command = vim.api.nvim_create_user_command

command("ReloadConfig", function()
  for loaded_name, _ in pairs(package.loaded) do
    for _, target_package in ipairs({ "user", "mini", "nvim%-treesitter" }) do
      if loaded_name:match("^" .. target_package) then
        package.loaded[loaded_name] = nil
      end
    end
  end

  dofile(vim.env.MYVIMRC)

  vim.notify("Reloaded " .. vim.env.MYVIMRC, vim.log.levels.INFO)
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
