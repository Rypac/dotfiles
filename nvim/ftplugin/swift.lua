vim.api.nvim_buf_create_user_command(
  0,
  "FoldImports",
  function()
    vim.cmd([[
      silent! normal! m`G
      silent! /\_^import\s\+/normal! mizf}``m`
      let @/ = ""
    ]])
  end,
  {
    desc = "Fold imports"
  }
)

vim.opt_local.formatprg = 'swift-format --assume-filename %'

vim.lsp.start({
  name = 'swift-language-server',
  cmd = {'xcrun', 'sourcekit-lsp'},
  root_dir = vim.fs.root(0, 'Package.swift')
})
