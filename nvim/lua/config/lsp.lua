vim.lsp.enable({
  "hls",
  "lua_ls",
  "sourcekit",
}, vim.g.lsp_autostart ~= false)

vim.diagnostic.config({
  virtual_text = true,
})
