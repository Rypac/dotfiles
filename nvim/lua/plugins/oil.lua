return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Oil",
  opts = {
    skip_confirm_for_simple_edits = true,
    columns = vim.env.TERM_PROGRAM ~= "Apple_Terminal" and { "icon" } or {},
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