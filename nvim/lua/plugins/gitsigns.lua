return {
  "lewis6991/gitsigns.nvim",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  cmd = "Gitsigns",
  opts = {},
  keys = {
    {
      "<leader>hs",
      "<cmd>Gitsigns stage_hunk<cr>",
      desc = "Stage Hunk",
      mode = { "n", "v" },
    },
    {
      "<leader>hr",
      "<cmd>Gitsigns reset_hunk<cr>",
      desc = "Reset Hunk",
      mode = { "n", "v" },
    },
    {
      "<leader>hp",
      "<cmd>Gitsigns preview_hunk<cr>",
      desc = "Preview Hunk",
    },
    {
      "<leader>hb",
      "<cmd>lua require('gitsigns').blame_line({full=true})<cr>",
      desc = "Blame",
    },
    {
      "<leader>hd",
      "<cmd>Gitsigns diffthis<cr>",
      desc = "Diff",
    },
    {
      "<leader>hD",
      "<cmd>lua require('gitsigns').diffthis('~')<cr>",
      desc = "Diff All",
    },
    {
      "<leader>htb",
      "<cmd>Gitsigns toggle_current_line_blame<cr>",
      desc = "Blame",
    },
    {
      "<leader>htd",
      "<cmd>Gitsigns toggle_deleted<cr>",
      desc = "Deleted",
    },
    {
      "<leader>htl",
      "<cmd>Gitsigns toggle_linehl<cr>",
      desc = "Highlight Line",
    },
    {
      "<leader>htn",
      "<cmd>Gitsigns toggle_numhl<cr>",
      desc = "Highlight Number",
    },
    {
      "<leader>hts",
      "<cmd>Gitsigns toggle_signs<cr>",
      desc = "Signs",
    },
    {
      "<leader>htw",
      "<cmd>Gitsigns toggle_word_diff<cr>",
      desc = "Word Diff",
    },
  },
}
