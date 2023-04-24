return {
  "jose-elias-alvarez/null-ls.nvim",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  version = false,
  opts = function()
    local null_ls = require("null-ls")
    return {
      sources = {
        null_ls.builtins.formatting.fourmolu,
        null_ls.builtins.formatting.jq,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.ruff,
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        }),
      },
    }
  end,
}
