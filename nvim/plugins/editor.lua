return {
  {
    "echasnovski/mini.align",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.align").setup()
    end,
  },
  {
    "echasnovski/mini.bracketed",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.bracketed").setup()
    end,
  },
  {
    "echasnovski/mini.comment",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.comment").setup()
    end,
  },
  {
    "echasnovski/mini.jump",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.jump").setup()
    end,
  },
  {
    "echasnovski/mini.move",
    version = "*",
    event = "VeryLazy",
    opts = {
      mappings = {
        line_right = "",
        line_left = "",
        line_down = "",
        line_up = "",
      },
    },
    config = function(_, opts)
      require("mini.move").setup(opts)
    end,
  },
  {
    "echasnovski/mini.pairs",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "mg979/vim-visual-multi",
    version = false,
    keys = {
      { "<M-j>", ":call vm#commands#add_cursor_down(0, v:count1)<cr>" },
      { "<M-k>", ":call vm#commands#add_cursor_up(0, v:count1)<cr>" },
      { "<M-Down>", ":call vm#commands#add_cursor_down(0, v:count1)<cr>" },
      { "<M-Up>", ":call vm#commands#add_cursor_up(0, v:count1)<cr>" },
      { "<C-LeftMouse>", "<Plug>(VM-Mouse-Cursor)" },
      { "<C-RightMouse>", "<Plug>(VM-Mouse-Word)" },
      { "<M-C-RightMouse>", "<Plug>(VM-Mouse-Column)" },
    },
  },
}
