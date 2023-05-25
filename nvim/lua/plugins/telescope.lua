local function telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts }
  return function()
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force", { cwd = vim.loop.cwd() }, opts or {})
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Telescope",
  opts = {
    defaults = {
      mappings = {
        n = {
          ["q"] = function(...)
            return require("telescope.actions").close(...)
          end,
        },
      },
    },
  },
  keys = {
    {
      "<C-p>",
      telescope("files"),
      desc = "Find Files",
    },
    {
      "<leader>/",
      telescope("live_grep"),
      desc = "Grep",
    },
    {
      "<leader>:",
      "<cmd>Telescope command_history<cr>",
      desc = "Command History",
    },
    {
      "<leader><space>",
      telescope("files"),
      desc = "Find Files",
    },
    {
      "<leader>fa",
      "<cmd>Telescope autocommands<cr>",
      desc = "Auto Commands",
    },
    {
      "<leader>fb",
      "<cmd>Telescope buffers show_all_buffers=true<cr>",
      desc = "Buffers",
    },
    {
      "<leader>fc",
      "<cmd>Telescope command_history<cr>",
      desc = "Command History",
    },
    {
      "<leader>fC",
      "<cmd>Telescope commands<cr>",
      desc = "Commands",
    },
    {
      "<leader>fd",
      "<cmd>Telescope diagnostics bufnr=0<cr>",
      desc = "Document diagnostics",
    },
    {
      "<leader>fD",
      "<cmd>Telescope diagnostics<cr>",
      desc = "Workspace diagnostics",
    },
    {
      "<leader>ff",
      telescope("files"),
      desc = "Find Files (root dir)",
    },
    {
      "<leader>fF",
      telescope("files", { cwd = false }),
      desc = "Find Files (cwd)",
    },
    {
      "<leader>fg",
      telescope("live_grep"),
      desc = "Grep (root dir)",
    },
    {
      "<leader>fG",
      telescope("live_grep", { cwd = false }),
      desc = "Grep (cwd)",
    },
    {
      "<leader>fh",
      "<cmd>Telescope help_tags<cr>",
      desc = "Help Pages",
    },
    {
      "<leader>fH",
      "<cmd>Telescope highlights<cr>",
      desc = "Search Highlight Groups",
    },
    {
      "<leader>fj",
      "<cmd>Telescope jumplist<cr>",
      desc = "Jump List",
    },
    {
      "<leader>fk",
      "<cmd>Telescope keymaps<cr>",
      desc = "Key Maps",
    },
    {
      "<leader>fl",
      "<cmd>Telescope current_buffer_fuzzy_find<cr>",
      desc = "Line",
    },
    {
      "<leader>fM",
      "<cmd>Telescope man_pages<cr>",
      desc = "Man Pages",
    },
    {
      "<leader>fm",
      "<cmd>Telescope marks<cr>",
      desc = "Jump to Mark",
    },
    {
      "<leader>fo",
      "<cmd>Telescope vim_options<cr>",
      desc = "Options",
    },
    {
      "<leader>fq",
      "<cmd>Telescope quickfix<cr>",
      desc = "Quickfix",
    },
    {
      "<leader>fQ",
      "<cmd>Telescope quickfixhistory<cr>",
      desc = "Quickfix History",
    },
    {
      "<leader>fr",
      "<cmd>Telescope oldfiles<cr>",
      desc = "Recents",
    },
    {
      "<leader>fR",
      "<cmd>Telescope resume<cr>",
      desc = "Resume",
    },
    {
      "<leader>fw",
      telescope("grep_string"),
      desc = "Word (root dir)",
    },
    {
      "<leader>fW",
      telescope("grep_string", { cwd = false }),
      desc = "Word (cwd)",
    },
    {
      "<leader>fU",
      telescope("colorscheme", { enable_preview = true }),
      desc = "Colorscheme",
    },
    {
      "<leader>fy",
      "<cmd>Telescope registers<cr>",
      desc = "Registers",
    },
    {
      "<leader>f?",
      "<cmd>Telescope spell_suggest<cr>",
      desc = "Spelling Suggestions",
    },
    {
      "<leader>fs",
      telescope("lsp_document_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
        },
      }),
      desc = "Goto Symbol",
    },
    {
      "<leader>fS",
      telescope("lsp_dynamic_workspace_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
        },
      }),
      desc = "Goto Symbol (Workspace)",
    },
  },
}
