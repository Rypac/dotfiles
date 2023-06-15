local on_attach = function(client, bufnr)
  local keys = {
    {
      "gr",
      "<cmd>Telescope lsp_references<cr>",
      desc = "References",
      capability = "referencesProvider",
    },
    {
      "gd",
      "<cmd>Telescope lsp_definitions<cr>",
      desc = "Goto Definition",
      capability = "definitionProvider",
      fallback = true,
    },
    {
      "gD",
      vim.lsp.buf.declaration,
      desc = "Goto Declaration",
      capability = "declarationProvider",
    },
    {
      "gy",
      "<cmd>Telescope lsp_type_definitions<cr>",
      desc = "Goto Type Definition",
      capability = "typeDefinitionProvider",
    },
    {
      "gs",
      "<cmd>Telescope lsp_document_symbols<cr>",
      desc = "Goto Symbols",
      capability = "documentSymbolProvider",
    },
    {
      "gS",
      "<cmd>Telescope lsp_workspace_symbols<cr>",
      desc = "Goto Workspace Symbols",
      capability = "workspaceSymbolProvider",
    },
    {
      "gi",
      "<cmd>Telescope lsp_implementations<cr>",
      desc = "Goto Implementation",
      capability = "implementationProvider",
    },
    {
      "K",
      vim.lsp.buf.hover,
      desc = "Hover",
      capability = "hoverProvider",
    },
    {
      "gK",
      vim.lsp.buf.signature_help,
      desc = "Signature Help",
      capability = "signatureHelpProvider",
    },
    {
      "<c-k>",
      vim.lsp.buf.signature_help,
      mode = "i",
      desc = "Signature Help",
      capability = "signatureHelpProvider",
    },
    {
      "<leader>cd",
      vim.diagnostic.open_float,
      desc = "Line Diagnostics",
      capability = "diagnosticProvider",
    },
    {
      "<leader>cr",
      vim.lsp.buf.rename,
      desc = "Rename Symbol",
      capability = "renameProvider",
    },
    {
      "<leader>cl",
      "<cmd>LspInfo<cr>",
      desc = "Lsp Info",
    },
    {
      "<leader>ca",
      vim.lsp.buf.code_action,
      desc = "Code Action",
      mode = { "n", "v" },
      capability = "codeActionProvider",
    },
    {
      "<leader>cf",
      function()
        vim.lsp.buf.format({ async = true })
      end,
      desc = "Format Document",
      capability = "documentFormattingProvider",
    },
    {
      "<leader>cf",
      function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
      desc = "Format Range",
      mode = "v",
      capability = "documentRangeFormattingProvider",
    },
  }

  for _, key in pairs(keys) do
    local has_capability = key.capability and client.server_capabilities[key.capability]
    local has_fallback = key.fallback or false

    if has_capability or not has_fallback then
      vim.keymap.set(key.mode or "n", key[1], key[2], {
        desc = key.desc,
        buffer = bufnr,
        silent = true,
        noremap = true,
      })
    end
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    opts = {
      servers = {
        hls = {
          filetypes = {
            "haskell",
            "lhaskell",
            "cabal",
          },
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
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
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
        local merged_opts = vim.tbl_deep_extend("force", {}, server_opts, {
          on_attach = on_attach,
        })
        lspconfig[server].setup(merged_opts)
      end
    end,
  },
}
