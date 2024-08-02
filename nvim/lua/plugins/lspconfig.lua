local lspconfig = require('lspconfig')

lspconfig.hls.setup({
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
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

lspconfig.sourcekit.setup({})
