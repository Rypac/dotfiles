local is_dark = vim.o.background == "dark"

require("mini.hues").setup({
  background = is_dark and "#161821" or "#e8e9ec",
  foreground = is_dark and "#c6c8d1" or "#33374c",
  saturation = is_dark and "lowmedium" or "mediumhigh",
  plugins = {
    default = false,
    ["echasnovski/mini.nvim"] = true,
  },
})

vim.g.colors_name = "iceberg"
