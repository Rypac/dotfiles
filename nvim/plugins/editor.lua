return {
  {
    "echasnovski/mini.ai",
    event = "BufReadPost",
    opts = function()
      local gen_spec = require("mini.ai").gen_spec
      return {
        custom_textobjects = {
          c = gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner",
          }),
          m = gen_spec.treesitter({
            a = "@function.outer",
            i = "@function.inner",
          }),
          o = gen_spec.treesitter({
            a = { "@conditional.outer", "@loop.outer" },
            i = { "@conditional.inner", "@loop.inner" },
          }),
        },
      }
    end,
  },
  {
    "echasnovski/mini.bracketed",
    event = "BufReadPost",
    opts = {
      comment = {
        suffix = "/",
      },
      oldfile = {
        suffix = "",
      },
    },
  },
  {
    "echasnovski/mini.comment",
    event = "BufReadPost",
    opts = {},
  },
  {
    "echasnovski/mini.completion",
    event = "InsertEnter",
    opts = {
      delay = {
        completion = 10000000,
      },
    },
  },
  {
    "echasnovski/mini.jump",
    event = "BufReadPost",
    opts = {
      delay = {
        highlight = 10000000,
      },
    },
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
  },
  {
    "echasnovski/mini.pairs",
    event = "BufReadPost",
    opts = {},
  },
  {
    "echasnovski/mini.splitjoin",
    event = "BufReadPost",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    event = "BufReadPost",
    opts = {
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
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)

      vim.keymap.del("x", "ys")
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
