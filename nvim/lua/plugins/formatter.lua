return {
  "mhartington/formatter.nvim",
  cmd = {
    "Format",
    "FormatLock",
    "FormatWrite",
    "FormatWriteLock",
  },
  opts = {
    filetype = {
      cabal = {
        function()
          return {
            exe = "cabal-fmt",
            stdin = true,
          }
        end,
      },
      haskell = {
        function()
          local util = require("formatter.util")
          return {
            exe = "fourmolu",
            args = {
              "--stdin-input-file",
              util.escape_path(util.get_current_buffer_file_path()),
            },
            stdin = true,
          }
        end,
      },
      json = {
        function()
          return {
            exe = "jq",
            args = { "." },
            stdin = true,
          }
        end,
      },
      lua = {
        function()
          local util = require("formatter.util")
          return {
            exe = "stylua",
            args = {
              "--search-parent-directories",
              "--stdin-filepath",
              util.escape_path(util.get_current_buffer_file_path()),
              "--",
              "-",
            },
            stdin = true,
          }
        end,
      },
      python = {
        function()
          local util = require("formatter.util")
          return {
            exe = "black",
            args = {
              "--stdin-filename",
              util.escape_path(util.get_current_buffer_file_path()),
              "--quiet",
              "--",
              "-",
            },
            stdin = true,
          }
        end,
      },
      rust = {
        function()
          return {
            exe = "rustfmt",
            stdin = true,
          }
        end,
      },
      sh = {
        function()
          return {
            exe = "shfmt",
            args = { "--simplify", "--indent=4", "--case-indent", "--", "-" },
            stdin = true,
          }
        end,
      },
      swift = {
        function()
          local util = require("formatter.util")
          return {
            exe = "swiftformat",
            args = {
              "--stdinpath",
              util.escape_path(util.get_current_buffer_file_path()),
            },
            stdin = true,
          }
        end,
      },
      terraform = {
        function()
          return {
            exe = "terraform",
            args = { "fmt", "-" },
            stdin = true,
          }
        end,
      },
      yaml = {
        function()
          return {
            exe = "yamlfmt",
            args = { "-in" },
            stdin = true,
          }
        end,
      },
    },
  },
  keys = {
    { "<leader>cf", "<cmd>Format<cr>", desc = "Format Document" },
    { "<leader>cF", "<cmd>FormatWrite<cr>", desc = "Format and Save Document" },
  },
}
