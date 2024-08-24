vim.opt_local.foldmethod = "expr"
vim.opt_local.formatprg = "fourmolu --quiet --stdin-input-file %"

local lsp_config = require("user.lsp").config("hls")
if lsp_config then
  vim.lsp.start(lsp_config)
end
