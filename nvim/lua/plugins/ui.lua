return {
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = {
      "AerialToggle",
      "AerialOpen",
      "AerialClose",
    },
    opts = {},
    keys = {
      {
        "<leader>s",
        "<cmd>AerialToggle<cr>",
        desc = "Toggle symbol outline",
      },
    },
  },
  {
    "echasnovski/mini.bufremove",
    opts = {},
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete()
        end,
        desc = "Delete buffer",
      },
      {
        "<leader>bD",
        function()
          require("mini.bufremove").delete(nil, true)
        end,
        desc = "Delete buffer ignoring changes",
      },
      {
        "<leader>bx",
        function()
          require("mini.bufremove").wipeout()
        end,
        desc = "Wipeout buffer",
      },
      {
        "<leader>bX",
        function()
          require("mini.bufremove").wipeout(nil, true)
        end,
        desc = "Wipeout buffer ignoring changes",
      },
      {
        "<leader>bh",
        function()
          require("mini.bufremove").unshow()
        end,
        desc = "Unshow buffer",
      },
      {
        "<leader>bH",
        function()
          require("mini.bufremove").unshow_in_window()
        end,
        desc = "Unshow buffer in window",
      },
    },
  },
  {
    "echasnovski/mini.starter",
    event = "VimEnter",
    opts = {},
  },
  {
    "echasnovski/mini.statusline",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
      use_icons = vim.env.TERM_PROGRAM ~= "Apple_Terminal",
    },
  },
  {
    "echasnovski/mini.tabline",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
      show_icons = vim.env.TERM_PROGRAM ~= "Apple_Terminal",
    },
  },
  {
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
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register({
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>h"] = { name = "+hunk" },
        ["<leader>ht"] = { name = "+toggle" },
        ["<leader>o"] = { name = "+option" },
        ["<leader>t"] = { name = "+tab" },
        ["<leader>x"] = { name = "+trouble" },
      })
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 1,
        width = 100,
        options = {
          cursorline = false,
          number = false,
          signcolumn = "no",
        },
      },
    },
    keys = {
      {
        "<leader>z",
        "<cmd>ZenMode<cr>",
        desc = "Zen Mode",
      },
    },
  },
}
