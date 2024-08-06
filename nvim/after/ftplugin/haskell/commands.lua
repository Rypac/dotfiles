vim.api.nvim_buf_create_user_command(
  0,
  'FoldImports',
  function()
    vim.cmd([[
      silent! normal! m`G
      silent! /\_^{-#\s\+LANGUAGE\s\+/normal! mlzf}``m`
      silent! /\_^module\s\+\_.\{-}where\s*\_$/normal! mevgnzf``m`
      silent! /\_^import\s\+/normal! mizf}``m`
      silent! /\_^main\s\+=/normal! mm``m`
      let @/ = ""
    ]])
  end,
  {
    desc = 'Fold imports, exports and language pragmas'
  }
)
