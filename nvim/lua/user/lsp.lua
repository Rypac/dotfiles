local M = {}

M.config = function(name, local_config)
  local ok, default_config = pcall(require, "user.lspconfig." .. name)
  if not ok then
    vim.notify("Cannot access configuration for " .. name .. ".", vim.log.levels.WARN)
    return
  end

  local client_config = {}
  for key, value in pairs(default_config) do
    if key == "root_dir" then
      client_config[key] = value()
    else
      client_config[key] = value
    end
  end

  if not local_config then
    return client_config
  end

  return vim.tbl_deep_extend("keep", local_config, client_config)
end

return M
