return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    opts = {
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      ensure_installed = {
        "bash",
        "c",
        "haskell",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "sql",
        "swift",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
    },
    keys = {
      { "<C-space>", desc = "Increment selection", mode = "x" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    keys = {
      {
        "[@",
        function()
          require("treesitter-context").go_to_context()
        end,
        desc = "Context start",
      },
    },
    config = function()
      require("treesitter-context").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    opts = {
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]m"] = { query = "@function.outer", desc = "Next function start" },
            ["]o"] = { query = { "@conditional.inner", "@conditional.outer" }, desc = "Next conditional start" },
          },
          goto_next_end = {
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]M"] = { query = "@function.outer", desc = "Next function end" },
            ["]O"] = { query = { "@conditional.inner", "@conditional.outer" }, desc = "Next conditional end" },
          },
          goto_previous_start = {
            ["[c"] = { query = "@class.outer", desc = "Previous class start" },
            ["[m"] = { query = "@function.outer", desc = "Previous function start" },
            ["[o"] = { query = { "@conditional.inner", "@conditional.outer" }, desc = "Previous conditional start" },
          },
          goto_previous_end = {
            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
            ["[M"] = { query = "@function.outer", desc = "Previous function end" },
            ["[O"] = { query = { "@conditional.inner", "@conditional.outer" }, desc = "Previous conditional end" },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
