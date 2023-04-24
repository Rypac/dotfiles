return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewFileHistory",
    "DiffviewFocusFiles",
    "DiffviewToggleFiles",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    use_icons = false,
  },
  keys = {
    { "<leader>dd", "<cmd>DiffviewOpen<cr>", desc = "Diff" },
    { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    { "<leader>db", "<cmd>DiffviewFileHistory<cr>", desc = "Branch History" },
  },
}
