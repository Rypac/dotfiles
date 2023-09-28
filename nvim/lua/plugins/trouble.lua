return {
  "folke/trouble.nvim",
  cmd = {
    "Trouble",
    "TroubleToggle",
    "TroubleClose",
    "TroubleRefresh",
  },
  opts = {
    icons = vim.env.TERM_PROGRAM ~= "Apple_Terminal",
  },
  keys = {
    {
      "<leader>xx",
      "<cmd>TroubleToggle<cr>",
      desc = "Toggle",
    },
    {
      "<leader>xd",
      "<cmd>TroubleToggle document_diagnostics<cr>",
      desc = "Document Diagnostics",
    },
    {
      "<leader>xw",
      "<cmd>TroubleToggle workspace_diagnostics<cr>",
      desc = "Workspace Diagnostics",
    },
    {
      "<leader>xq",
      "<cmd>TroubleToggle quickfix<cr>",
      desc = "Quick Fix",
    },
    {
      "<leader>xl",
      "<cmd>TroubleToggle loclist<cr>",
      desc = "Locations",
    },
  },
}
