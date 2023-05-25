return {
  {
    "echasnovski/mini.ai",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    opts = function()
      local gen_spec = require("mini.ai").gen_spec
      return {
        custom_textobjects = {
          a = gen_spec.treesitter({
            a = "@parameter.outer",
            i = "@parameter.inner",
          }),
          c = gen_spec.treesitter({
            a = "@class.outer",
            i = "@class.inner",
          }),
          C = gen_spec.treesitter({
            a = "@comment.outer",
            i = "@comment.inner",
          }),
          f = gen_spec.treesitter({
            a = "@call.outer",
            i = "@call.inner",
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
    event = "VeryLazy",
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
    event = "VeryLazy",
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
    event = "VeryLazy",
    opts = {
      delay = {
        highlight = 10000000,
      },
    },
  },
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "echasnovski/mini.splitjoin",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
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
      vim.keymap.set("x", "S", ":<C-u>lua MiniSurround.add('visual')<cr>", { silent = true })
      vim.keymap.set("n", "yss", "ys_", { remap = true })
    end,
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    keys = {
      {
        "<C-j>",
        ":call vm#commands#add_cursor_down(0, v:count1)<cr>",
        desc = "Add cursor down",
      },
      {
        "<C-k>",
        ":call vm#commands#add_cursor_up(0, v:count1)<cr>",
        desc = "Add cursor up",
      },
      {
        "<C-LeftMouse>",
        "<Plug>(VM-Mouse-Cursor)",
      },
      {
        "<C-RightMouse>",
        "<Plug>(VM-Mouse-Word)",
      },
      {
        "<M-C-RightMouse>",
        "<Plug>(VM-Mouse-Column)",
      },
    },
    config = function()
      vim.g.VM_theme = "nord"
    end,
  },
}
