return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "nord",
        icons_enabled = false,
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_b = {},
        lualine_x = { "diagnostics", "diff", "branch" },
        lualine_y = {},
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        spelling = true,
      },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gd"] = { name = "+diff" },
        ["<leader>gh"] = { name = "+github" },
        ["<leader>ghc"] = { name = "+commit" },
        ["<leader>ghi"] = { name = "+issue" },
        ["<leader>ghr"] = { name = "+review" },
        ["<leader>ghp"] = { name = "+pull request" },
        ["<leader>ght"] = { name = "+thread" },
        ["<leader>h"] = { name = "+hunk" },
        ["<leader>ht"] = { name = "+toggle" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>t"] = { name = "+tabs" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics" },
      },
    },
    config = function(_, opts)
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300

      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    cmd = "Gitsigns",
    keys = {
      { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk", mode = { "n", "v" } },
      { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk", mode = { "n", "v" } },
      { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
      { "<leader>hb", "<cmd>lua require('gitsigns').blame_line({full=true})<cr>", desc = "Blame" },
      { "<leader>hd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff" },
      { "<leader>hD", "<cmd>lua require('gitsigns').diffthis('~')<cr>", desc = "Diff All" },
      { "<leader>htb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Blame" },
      { "<leader>htd", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Deleted" },
      { "<leader>htl", "<cmd>Gitsigns toggle_linehl<cr>", desc = "Highlight Line" },
      { "<leader>htn", "<cmd>Gitsigns toggle_numhl<cr>", desc = "Highlight Number" },
      { "<leader>hts", "<cmd>Gitsigns toggle_signs<cr>", desc = "Signs" },
      { "<leader>htw", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "Word Diff" },
    },
    config = true,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 1,
        width = 100,
        options = {
          number = false,
          cursorline = false,
        },
      },
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },
}
