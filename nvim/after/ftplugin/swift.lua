vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2

vim.opt_local.foldmethod = "expr"
vim.opt_local.formatprg = "swift-format --assume-filename %"

vim.opt_local.commentstring = "// %s"

require("user.lsp").start("sourcekit")
