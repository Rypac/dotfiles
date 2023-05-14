return {
  "mhartington/formatter.nvim",
  cmd = {
    "Format",
    "FormatLock",
    "FormatWrite",
    "FormatWriteLock",
  },
  keys = {
    { "<leader>cf", "<cmd>Format<cr>", desc = "Format Document" },
    { "<leader>cF", "<cmd>FormatWrite<cr>", desc = "Format and Save Document" },
  },
  config = function()
    require("formatter").setup({
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
            return {
              exe = "black",
              args = {
                "--stdin-filename",
                util.escape_path(util.get_current_buffer_file_path()),
                "--quiet",
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
        swift = {
          function()
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
      },
    })
  end,
}
