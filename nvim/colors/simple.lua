local is_dark = vim.o.background == "dark"

require("mini.hues").setup({
  accent = "bg",
  background = is_dark and "#0f2725" or "#e4e1e8",
  foreground = is_dark and "#c0c9c8" or "#2f2d33",
  saturation = is_dark and "medium" or "high",
  plugins = {
    default = false,
    ["echasnovski/mini.nvim"] = true,
  },
})

vim.g.colors_name = "simple"
