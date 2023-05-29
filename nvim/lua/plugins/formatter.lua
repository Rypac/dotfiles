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
          return {
            exe = "fourmolu",
            args = {
              "--stdin-input-file",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
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
          return {
            exe = "stylua",
            args = {
              "--search-parent-directories",
              "--stdin-filepath",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
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
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
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
          return {
            exe = "swiftformat",
            args = {
              "--stdinpath",
              vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
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
    {
      "<leader>cf",
      "<cmd>Format<cr>",
      desc = "Format Document",
    },
    {
      "<leader>cF",
      "<cmd>FormatWrite<cr>",
      desc = "Format and Save Document",
    },
  },
}
