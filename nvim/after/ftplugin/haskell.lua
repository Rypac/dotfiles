vim.opt_local.foldmethod = "expr"
vim.opt_local.formatprg = "fourmolu --quiet --stdin-input-file %"

local lsp_config = require("user.lsp.hls")
vim.lsp.start(lsp_config)