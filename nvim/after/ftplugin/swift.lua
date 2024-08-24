vim.opt_local.foldmethod = "expr"
vim.opt_local.formatprg = "swift-format --assume-filename %"

local lsp_config = require("user.lsp").config("sourcekit")
if lsp_config then
  vim.lsp.start(lsp_config)
end
