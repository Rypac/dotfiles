return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  opts = {
    view_options = {
      show_hidden = true,
    },
    float = {
      win_options = {
        winblend = 0,
      },
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("oil").open()
      end,
      desc = "Open Directory",
    },
    {
      "<leader>E",
      function()
        require("oil").open_float()
      end,
      desc = "Open Directory (Float)",
    },
  },
}
