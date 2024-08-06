vim.api.nvim_buf_create_user_command(
  0,
  'FoldImports',
  function()
    vim.cmd([[
      silent! normal! m`G
      silent! /\_^import\s\+/normal! mizf}``m`
      let @/ = ""
    ]])
  end,
  {
    desc = 'Fold imports'
  }
)
