return {
  "echasnovski/mini.move",
  version = "*",
  opts = {
    mappings = {
      line_right = "",
      line_left = "",
      line_down = "",
      line_up = "",
    },
  },
  config = function(_, opts)
    require("mini.move").setup(opts)
  end,
}