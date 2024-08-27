local M = {}

M.config = function(name, local_config)
  local ok, config = pcall(require, "user.lspconfig." .. name)
  if not ok then
    vim.notify("Cannot access configuration for " .. name .. ".", vim.log.levels.WARN)
    return
  end

  if not local_config then
    return config()
  end

  return vim.tbl_deep_extend("force", config(), local_config)
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
