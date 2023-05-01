return {
  {
    "arcticicestudio/nord-vim",
    version = false,
    lazy = false,
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
    "ellisonleao/gruvbox.nvim",
    version = false,
    lazy = true,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
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
    opts = {
      style = "warm",
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      vim.cmd([[colorscheme onedark]])
    end,
  },
}
