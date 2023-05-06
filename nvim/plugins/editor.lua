return {
  {
    "echasnovski/mini.align",
    event = "BufReadPost",
    config = function()
      require("mini.align").setup()
    end,
  },
  {
    "echasnovski/mini.bracketed",
    event = "BufReadPost",
    config = function()
      require("mini.bracketed").setup()
    end,
  },
  {
    "echasnovski/mini.comment",
    event = "BufReadPost",
    config = function()
      require("mini.comment").setup()
    end,
  },
  {
    "echasnovski/mini.jump",
    event = "BufReadPost",
    config = function()
      require("mini.jump").setup()
    end,
  },
  {
    "echasnovski/mini.move",
    event = "BufReadPost",
    opts = {
      mappings = {
        down = "J",
        up = "K",
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
    event = "BufReadPost",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "echasnovski/mini.surround",
    event = "BufReadPost",
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "mg979/vim-visual-multi",
    event = "BufReadPost",
    keys = {
      { "<M-j>", ":call vm#commands#add_cursor_down(0, v:count1)<cr>" },
      { "<M-k>", ":call vm#commands#add_cursor_up(0, v:count1)<cr>" },
      { "<M-Down>", ":call vm#commands#add_cursor_down(0, v:count1)<cr>" },
      { "<M-Up>", ":call vm#commands#add_cursor_up(0, v:count1)<cr>" },
      { "<C-LeftMouse>", "<Plug>(VM-Mouse-Cursor)" },
      { "<C-RightMouse>", "<Plug>(VM-Mouse-Word)" },
      { "<M-C-RightMouse>", "<Plug>(VM-Mouse-Column)" },
    },
    config = function()
      vim.g.VM_theme = "nord"
    end,
  },
}
