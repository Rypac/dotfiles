return {
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "cabal" },
  root_dir = function(_, callback)
    local root_dir = vim.fs.root(0, function(name)
      return name:match("%.cabal$") ~= nil
    end)

    if root_dir ~= nil then
      callback(root_dir)
    end
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
