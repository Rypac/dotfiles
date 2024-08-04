vim.opt_local.formatprg = 'cabal-gild --stdin %'

local lsp_config = require('lsp.hls')
vim.lsp.start(lsp_config)
