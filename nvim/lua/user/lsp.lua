local M = {}

M.config = function(name, local_config)
  local ok, config = pcall(require, "user.lspconfig." .. name)
  if not ok then
    vim.notify("Cannot access configuration for " .. name .. ".", vim.log.levels.WARN)
    return
  end

  if local_config then
    config = vim.tbl_deep_extend("force", config, local_config)
  end

  local client_config = {}
  for key, value in pairs(config) do
    if key == "root_dir" and vim.is_callable(value) then
      client_config[key] = value()
    else
      client_config[key] = value
    end
  end

  return client_config
end

M.start = function(name, config, opts)
  if vim.g.lsp_autostart == false or vim.b.lsp_autostart == false then
    return
  end

  local lsp_config = M.config(name, config)
  if lsp_config then
    vim.lsp.start(lsp_config, opts)
  end
end

return M
