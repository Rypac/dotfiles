return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  opts = {
    window = {
      backdrop = 1,
      width = 100,
      options = {
        number = false,
        cursorline = false,
      },
    },
  },
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
  },
}
