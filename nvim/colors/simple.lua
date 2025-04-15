local is_dark = vim.o.background == "dark"

require("mini.hues").setup({
  background = is_dark and "#122722" or "#dce4e8",
  foreground = is_dark and "#c0c9c6" or "#292f32",
  saturation = is_dark and "medium" or "high",
  plugins = {
    default = false,
    ["echasnovski/mini.nvim"] = true,
  },
})

vim.g.colors_name = "simple"
