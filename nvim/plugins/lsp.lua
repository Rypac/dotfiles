local on_attach = function(client, bufnr)
  keys = {
    { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
    { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    { "gy", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
    { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
    { "K", vim.lsp.buf.hover, desc = "Hover" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
    { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
    { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename Symbol" },
    { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
    {
      "<leader>cf",
      function()
        vim.lsp.buf.format({ async = true })
      end,
      desc = "Format Document",
    },
    {
      "<leader>cf",
      function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
      desc = "Format Range",
      mode = "v",
    },
    {
      "<leader>ca",
      vim.lsp.buf.code_action,
      desc = "Code Action",
      mode = { "n", "v" },
    },
  }

  for _, key in pairs(keys) do
    vim.keymap.set(key.mode or "n", key[1], key[2], {
      desc = key.desc,
      buffer = bufnr,
      silent = true,
      noremap = true,
    })
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    opts = {
      servers = {
        hls = {
          filetypes = { "haskell", "lhaskell", "cabal" },
          settings = {
            haskell = {
              formattingProvider = "fourmolu",
              plugin = {
                rename = {
                  config = {
                    crossModule = true,
                  },
                },
              },
            },
          },
        },
        sourcekit = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      local servers = opts.servers or {}
      for server, server_opts in pairs(servers) do
        local merged_opts = vim.tbl_deep_extend("force", {}, server_opts, { on_attach = on_attach })
        lspconfig[server].setup(merged_opts)
      end
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    opts = function()
      local null_ls = require("null-ls")
      return {
        on_attach = on_attach,
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.cabal_fmt,
          null_ls.builtins.formatting.fourmolu,
          null_ls.builtins.formatting.jq,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          }),
        },
      }
    end,
  },
}
