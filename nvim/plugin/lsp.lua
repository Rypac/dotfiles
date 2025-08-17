vim.lsp.enable({
  "gopls",
  "hls",
  "lua_ls",
  "ruff",
  "sourcekit",
})

vim.api.nvim_create_user_command("LspStart", "edit", {
  desc = "Start LSP",
})

vim.api.nvim_create_user_command("LspRestart", function()
  vim.lsp.stop_client(vim.lsp.get_clients())
  vim.cmd("edit")
end, {
  desc = "Restart LSP",
})

vim.api.nvim_create_user_command("LspStop", function()
  vim.lsp.stop_client(vim.lsp.get_clients())
end, {
  desc = "Stop LSP",
})

vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", {
  desc = "Open LSP healthcheck",
})

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd("tabnew " .. vim.lsp.log.get_filename())
end, {
  desc = "Open LSP logs",
})

local lsp_group = vim.api.nvim_create_augroup("UserLspConfiguration", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Configure buffer on LSP attach",
  group = lsp_group,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    local methods = vim.lsp.protocol.Methods

    if client:supports_method(methods.textDocument_definition) then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
        desc = "Go to definition",
        buffer = args.buf,
      })
    end

    if client:supports_method(methods.textDocument_declaration) then
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {
        desc = "Go to declaration",
        buffer = args.buf,
      })
    end

    if client:supports_method(methods.textDocument_formatting) then
      vim.keymap.set("n", "g=", vim.lsp.buf.format, {
        desc = "Format buffer",
        buffer = args.buf,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_group,
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({
            bufnr = args.buf,
            id = client.id,
            filter = function()
              return vim.g.lsp_autoformat ~= false and vim.b[args.buf].lsp_autoformat ~= false
            end,
          })
        end,
      })
    end

    if client:supports_method(methods.textDocument_foldingRange) then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = "expr"
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"

      vim.api.nvim_create_autocmd("LspNotify", {
        group = lsp_group,
        buffer = args.buf,
        callback = function(args)
          if args.data.method == methods.textDocument_didOpen then
            vim.lsp.foldclose("imports", vim.fn.bufwinid(args.buf))
          end
        end,
      })
    end

    if client:supports_method(methods.textDocument_codeLens) then
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        group = lsp_group,
        buffer = args.buf,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = args.buf })
        end,
      })
    end

    if client:supports_method(methods.textDocument_completion) then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client:supports_method(methods.textDocument_documentHighlight) then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = lsp_group,
        buffer = args.buf,
        callback = function()
          if vim.g.document_highlight ~= false and vim.b[args.buf].document_highlight ~= false then
            vim.lsp.buf.document_highlight()
          end
        end,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = lsp_group,
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.clear_references()
        end,
      })
    end

    vim.api.nvim_set_option_value("signcolumn", "yes", { scope = "local" })
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  desc = "Cleanup buffer on LSP detach",
  group = lsp_group,
  callback = function(args)
    vim.lsp.buf.clear_references()
    vim.api.nvim_clear_autocmds({ group = lsp_group, buffer = args.buf })
  end,
})

vim.keymap.set({ "n", "v" }, "g.", vim.lsp.buf.code_action, {
  desc = "vim.lsp.buf.codeaction()",
})

vim.keymap.set("n", "gro", vim.lsp.buf.outgoing_calls, {
  desc = "vim.lsp.buf.outgoing_calls()",
})

vim.keymap.set("n", "grs", vim.lsp.buf.document_symbol, {
  desc = "vim.lsp.buf.document_symbol()",
})

vim.keymap.set("n", "grS", vim.lsp.buf.workspace_symbol, {
  desc = "vim.lsp.buf.workspace_symbol()",
})

vim.keymap.set("n", "grt", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {
  desc = "vim.lsp.inlay_lint.enable()",
})

vim.keymap.set("n", "gry", vim.lsp.buf.type_definition, {
  desc = "vim.lsp.buf.type_definition()",
})
