return {
  name = "haskell-language-server",
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  root_dir = function()
    return vim.fs.root(0, function(name)
      return name:match("%.cabal$") ~= nil
    end)
  end,
  settings = {
    haskell = {
      formattingProvider = "fourmolu",
      cabalFormattingProvider = "cabal-gild",
      plugin = {
        rename = {
          config = {
            crossModule = true,
          },
        },
      },
    },
  },
}
