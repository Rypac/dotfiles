vim.opt_local.foldmethod = "expr"
vim.opt_local.formatprg = "swift-format --assume-filename %"

require("user.lsp").start("sourcekit")
