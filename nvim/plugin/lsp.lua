if vim.g.loaded_user_lsp ~= nil then
  return
end
vim.g.loaded_user_lsp = 1

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

vim.api.nvim_create_user_command("LspInfo", "checkhealth lsp", {
  desc = "Open LSP healthcheck",
})

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd("tabnew " .. vim.lsp.log.get_filename())
end, {
  desc = "Open LSP logs",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfiguration", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local methods = vim.lsp.protocol.Methods.textDocument_inlayHint

    if client.supports_method(methods.textDocument_definition) then
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
    end

    if client.supports_method(methods.textDocument_declaration) then
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf })
    end

    if client.supports_method(methods.textDocument_formatting) then
      vim.keymap.set("n", "g=", vim.lsp.buf.format, { buffer = args.buf })

      local format_augroup = vim.api.nvim_create_augroup("UserLspFormatOnSave", { clear = true })

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = format_augroup,
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({
            bufnr = args.buf,
            id = client.id,
            filter = function()
              return vim.g.autoformat ~= false and vim.b[args.buf].autoformat ~= false
            end,
          })
        end,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("UserLspFormatOnSaveCleanup", { clear = true }),
        buffer = args.buf,
        once = true,
        callback = function()
          vim.api.nvim_clear_autocmds({ group = format_augroup, buffer = args.buf })
        end,
      })
    end

    if client.supports_method(methods.textDocument_codeLens) then
      vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("UserLspCodeLens", { clear = true }),
        buffer = args.buf,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = args.buf })
        end,
      })
    end

    if client.supports_method(methods.textDocument_completion) then
      if vim.fn.has("nvim-0.11") == 1 then
        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      end
    end

    if client.supports_method(methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("UserLspHighlight", { clear = true })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = highlight_augroup,
        buffer = args.buf,
        callback = function()
          if vim.g.document_highlight ~= false and vim.b[args.buf].document_highlight ~= false then
            vim.lsp.buf.document_highlight()
          end
        end,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        group = highlight_augroup,
        buffer = args.buf,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("UserLspHighlightCleanup", { clear = true }),
        buffer = args.buf,
        once = true,
        callback = function()
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = args.buf })
        end,
      })
    end

    vim.api.nvim_buf_set_option(args.buf, "signcolumn", "yes")
  end,
})
