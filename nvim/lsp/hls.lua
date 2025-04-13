return {
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "cabal" },
  root_dir = function(bufnr, callback)
    local markers = { "hie.yaml", "stack.yaml", "cabal.project", "package.yaml" }

    callback(vim.fs.root(bufnr, function(name)
      for _, marker in ipairs(markers) do
        if marker == name then
          return true
        end
      end

      return name:match("%.cabal$") ~= nil
    end))
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
