local is_apple_terminal = vim.env.TERM_PROGRAM == "Apple_Terminal"

return {
  {
    "arcticicestudio/nord-vim",
    version = false,
    lazy = not is_apple_terminal,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme nord]])
    end,
  },
  {
    "shaunsingh/nord.nvim",
    version = false,
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
    version = false,
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
    version = false,
    lazy = true,
    config = function()
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    version = false,
    lazy = true,
    config = function()
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
  {
    "kaiuri/nvim-juliana",
    version = false,
    lazy = true,
    config = function()
      vim.cmd([[colorscheme juliana]])
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    version = false,
    lazy = true,
    config = function()
      vim.cmd([[colorscheme nightfox]])
    end,
  },
  {
    "sainnhe/everforest",
    version = false,
    lazy = true,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd([[colorscheme everforest]])
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    version = false,
    lazy = true,
    config = function()
      vim.cmd([[colorscheme kanagawa]])
    end,
  },
  {
    "navarasu/onedark.nvim",
    version = false,
    lazy = true,
    config = function()
      require("onedark").setup({ style = "warm" })
      vim.cmd([[colorscheme onedark]])
    end,
  },
}
