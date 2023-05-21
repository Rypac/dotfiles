return {
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "G",
    },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>", desc = "Status" },
      { "<leader>gb", "<cmd>Git blame<cr>", desc = "Blame" },
      { "<leader>gl", "<cmd>Git log<cr>", desc = "Log" },
      { "<leader>gf", "<cmd>Git fetch<cr>", desc = "Fetch" },
      { "<leader>gp", "<cmd>Git pull<cr>", desc = "Pull" },
      { "<leader>gP", "<cmd>Git push<cr>", desc = "Push" },
      { "<leader>gr", "<cmd>Git rebase<cr>", desc = "Rebase" },
      { "<leader>gr", "<cmd>Git revert<cr>", desc = "Revert" },
      { "<leader>gm", "<cmd>Git merge<cr>", desc = "Merge" },
    },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
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
      { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Diff" },
      { "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
      { "<leader>gdb", "<cmd>DiffviewFileHistory<cr>", desc = "Branch History" },
    },
  },
}
