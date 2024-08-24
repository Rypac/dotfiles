vim.opt_local.foldmethod = "expr"
vim.opt_local.formatprg = "fourmolu --quiet --stdin-input-file %"

require("user.lsp").start("hls")
