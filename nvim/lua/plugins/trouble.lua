return {
  "folke/trouble.nvim",
  cmd = {
    "Trouble",
    "TroubleToggle",
    "TroubleClose",
    "TroubleRefresh",
  },
  opts = {
    icons = false,
    fold_open = "v",
    fold_closed = ">",
    indent_lines = false,
    signs = {
      error = "error",
      warning = "warn",
      hint = "hint",
      information = "info",
    },
    use_diagnostic_signs = false,
  },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle" },
    { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics" },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Quick Fix" },
    { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Locations" },
  },
}
