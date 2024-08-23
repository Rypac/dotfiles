vim.opt_local.foldmethod = "expr"
vim.opt_local.formatprg = "swift-format --assume-filename %"

local lsp_config = require("user.lsp").config("sourcekit")
vim.lsp.start(lsp_config)
