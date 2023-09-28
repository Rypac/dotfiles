return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewFileHistory",
    "DiffviewFocusFiles",
    "DiffviewToggleFiles",
  },
  opts = {
    use_icons = vim.env.TERM_PROGRAM ~= "Apple_Terminal",
  },
  keys = {
    {
      "<leader>gd",
      "<cmd>DiffviewOpen<cr>",
      desc = "Diff",
    },
    {
      "<leader>gh",
      "<cmd>DiffviewFileHistory %<cr>",
      desc = "File History",
    },
    {
      "<leader>gH",
      "<cmd>DiffviewFileHistory<cr>",
      desc = "Branch History",
    },
  },
}
