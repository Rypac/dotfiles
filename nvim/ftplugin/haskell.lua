vim.api.nvim_buf_create_user_command(
  0,
  "FoldImports",
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
    desc = "Fold imports, exports and language pragmas"
  }
)

vim.opt_local.formatprg = 'fourmolu --quiet --stdin-input-file %'

vim.lsp.start({
  name = 'haskell-language-server',
  cmd = {'haskell-language-server-wrapper', '--lsp'},
  root_dir = vim.fs.root(0, function(name, path)
    return name:match('%.cabal$') ~= nil
  end),
  settings = {
    haskell = {
      formattingProvider = 'fourmolu',
      cabalFormattingProvider = 'cabal-gild',
      plugin = {
        rename = {
          config = {
            crossModule = true
          }
        }
      }
    }
  }
})
