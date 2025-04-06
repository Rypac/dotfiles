local is_dark = vim.o.background == "dark"

require("mini.hues").setup({
  background = is_dark and "#272E33" or "#FFFBEF",
  foreground = is_dark and "#D3C6AA" or "#5C6A72",
  plugins = {
    default = false,
    ["echasnovski/mini.nvim"] = true,
  },
})

vim.g.colors_name = "forest"
