return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "gruvbox-material",
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
        ["<leader>d"] = { name = "+diff" },
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
