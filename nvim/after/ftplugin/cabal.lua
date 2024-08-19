vim.opt_local.formatprg = "cabal-gild --stdin %"

-- Disable document highlighting until it is suppored by HLS
vim.b.document_highlight = false

local lsp_config = require("user.lsp.hls")
vim.lsp.start(lsp_config)
