return {
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
      require("mini.surround").setup({
        mappings = {
          add = "ys",
          delete = "ds",
          find = "",
          find_left = "",
          highlight = "",
          replace = "cs",
          update_n_lines = "",
        },
        search_method = "cover_or_next",
      })

      vim.keymap.del('x', 'ys')
      vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
      vim.keymap.set("n", "yss", "ys_", { remap = true })
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
