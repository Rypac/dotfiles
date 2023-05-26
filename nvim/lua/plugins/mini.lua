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
    "echasnovski/mini.align",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.basics",
    lazy = false,
    opts = {
      mappings = {
        option_toggle_prefix = "<leader>o",
      },
    },
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
    "echasnovski/mini.sessions",
    lazy = false,
    opts = {},
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
    "echasnovski/mini.tabline",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
      show_icons = vim.env.TERM_PROGRAM ~= "Apple_Terminal",
    },
  },
}
