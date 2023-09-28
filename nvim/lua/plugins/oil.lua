return {
  "stevearc/oil.nvim",
  lazy = false,
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
        require("oil").toggle_float()
      end,
      desc = "Toggle Directory (Float)",
    },
  },
}
