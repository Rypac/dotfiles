vim.api.nvim_create_user_command("ReloadConfig", function()
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
