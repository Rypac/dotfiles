return {
  "tpope/vim-fugitive",
  cmd = {
    "G",
    "Git",
    "Ggrep",
    "Gedit",
    "Gsplit",
    "Gvsplit",
    "Gread",
    "Gwrite",
    "Gdiffsplit",
    "Gvdiffsplit",
    "GBrowse",
  },
  keys = {
    {
      "<leader>gs",
      "<cmd>Git<cr>",
      desc = "Status",
    },
    {
      "<leader>gb",
      "<cmd>Git blame<cr>",
      desc = "Blame",
    },
    {
      "<leader>gl",
      "<cmd>Git log<cr>",
      desc = "Log",
    },
    {
      "<leader>gf",
      "<cmd>Git fetch<cr>",
      desc = "Fetch",
    },
    {
      "<leader>gp",
      "<cmd>Git pull<cr>",
      desc = "Pull",
    },
    {
      "<leader>gP",
      "<cmd>Git push<cr>",
      desc = "Push",
    },
    {
      "<leader>gr",
      "<cmd>Git rebase<cr>",
      desc = "Rebase",
    },
    {
      "<leader>gR",
      "<cmd>Git revert<cr>",
      desc = "Revert",
    },
    {
      "<leader>gm",
      "<cmd>Git merge<cr>",
      desc = "Merge",
    },
  },
}
