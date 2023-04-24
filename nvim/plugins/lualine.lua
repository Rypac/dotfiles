return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      icons_enabled = false,
      section_separators = "",
      component_separators = "",
    },
    sections = {
      lualine_b = {},
      lualine_x = {"diagnostics", "diff", "branch"},
      lualine_y = {},
    },
  },
}
