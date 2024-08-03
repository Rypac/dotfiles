vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspConfiguration', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client.supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    end

    if client.supports_method('textDocument/declaration') then
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
    end

    if client.supports_method('textDocument/formatting') then
      vim.keymap.set('n', 'g=', vim.lsp.buf.format)

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('LspFormatOnSave', { clear = true }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('LspFormatOnSaveCleanup', { clear = true }),
        buffer = args.buf,
        callback = function(event)
          vim.api.nvim_clear_autocmds({ group = 'LspFormatOnSave', buffer = event.buf })
        end
      })
    end

    if client.supports_method('textDocument/rangeFormatting') then
      vim.keymap.set('v', 'g=', vim.lsp.buf.format)
    end

    if client.supports_method('textDocument/codeLens') then
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('LspCodeLens', { clear = true }),
        buffer = args.buf,
        callback = function()
          vim.lsp.codelens.refresh({ bufnr = args.buf })
        end
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('LspCodeLensCleanup', { clear = true }),
        buffer = args.buf,
        callback = function(event)
          vim.lsp.codelens.clear(event.data.client_id, event.buf)
          vim.api.nvim_clear_autocmds({ group = 'LspCodeLens', buffer = event.buf })
        end
      })
    end

    if client.supports_method('textDocument/completion') then
      -- Supported on neovim v0.11 and up
      -- vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      -- vim.keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.completion.trigger()<cr>')
    end

    if client.supports_method('textDocument/documentHighlight') then
      local highlight_augroup = vim.api.nvim_create_augroup('LspHighlight', { clear = true })

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = highlight_augroup,
        buffer = args.buf,
        callback = vim.lsp.buf.document_highlight
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = highlight_augroup,
        buffer = args.buf,
        callback = vim.lsp.buf.clear_references
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('LspHighlightCleanup', { clear = true }),
        callback = function(event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = 'LspHighlight', buffer = event.buf })
        end
      })
    end

    vim.api.nvim_buf_set_option(args.buf, 'signcolumn', 'yes')
  end
})
