return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  opts = {
    window = {
      backdrop = 1,
      width = 100,
      options = {
        cursorline = false,
        number = false,
        signcolumn = "no",
      },
    },
  },
  keys = {
    {
      "<leader>z",
      "<cmd>ZenMode<cr>",
      desc = "Zen Mode",
    },
  },
}
