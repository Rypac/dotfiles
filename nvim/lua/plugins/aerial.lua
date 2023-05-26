return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = {
    "AerialToggle",
    "AerialOpen",
    "AerialOpenAll",
    "AerialClose",
    "AerialCloseAll",
  },
  opts = {},
  keys = {
    {
      "<leader>s",
      "<cmd>AerialToggle<cr>",
      desc = "Toggle symbol outline",
    },
  },
}
