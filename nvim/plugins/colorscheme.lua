local is_apple_terminal = vim.env.TERM_PROGRAM == "Apple_Terminal"

return {
  {
    "arcticicestudio/nord-vim",
    lazy = not is_apple_terminal,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme nord]])
    end,
  },
  {
    "shaunsingh/nord.nvim",
    lazy = true,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_italic = false

      require("nord").set()

      vim.cmd([[colorscheme nord]])
    end,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = is_apple_terminal,
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true

      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_statusline_style = "mix"

      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    config = function()
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
  {
    "kaiuri/nvim-juliana",
    lazy = true,
    config = function()
      vim.cmd([[colorscheme juliana]])
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    config = function()
      vim.cmd([[colorscheme nightfox]])
    end,
  },
  {
    "sainnhe/everforest",
    lazy = true,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd([[colorscheme everforest]])
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      vim.cmd([[colorscheme kanagawa]])
    end,
  },
  {
    "navarasu/onedark.nvim",
    lazy = true,
    config = function()
      require("onedark").setup({ style = "warm" })
      vim.cmd([[colorscheme onedark]])
    end,
  },
}
