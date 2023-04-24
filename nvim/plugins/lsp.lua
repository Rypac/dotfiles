return {
  "neovim/nvim-lspconfig",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  opts = {
    servers = {
      hls = {
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
  keys = {
    { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
    { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    { "gT", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
    { "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
    { "K", vim.lsp.buf.hover, desc = "Hover" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
    { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
    { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename Symbol" },
    { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
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
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
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
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")

    local servers = opts.servers or {}
    for server, server_opts in pairs(servers) do
      lspconfig[server].setup(server_opts)
    end
  end,
}
