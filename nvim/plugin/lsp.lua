vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspConfiguration', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client.supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
    end

    if client.supports_method('textDocument/declaration') then
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = args.buf })
    end

    if client.supports_method('textDocument/typeDefinition') then
      vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { buffer = args.buf })
    end

    if client.supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gY', vim.lsp.buf.implementation, { buffer = args.buf })
    end

    if client.supports_method('textDocument/formatting') then
      vim.keymap.set('n', 'g=', vim.lsp.buf.format, { buffer = args.buf })

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('LspFormatOnSave', { clear = true }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
        end
      })
    end

    if client.supports_method('textDocument/rangeFormatting') then
      vim.keymap.set('v', 'g=', vim.lsp.buf.format, { buffer = args.buf })
    end

    if client.supports_method('textDocument/references') then
      vim.keymap.set('n', 'grr', vim.lsp.buf.references, { buffer = args.buf })
    end

    if client.supports_method('textDocument/rename') then
      vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { buffer = args.buf })
    end

    if client.supports_method('textDocument/codeAction') then
      vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, { buffer = args.buf })
    end

    if client.supports_method('textDocument/inlayHint') then
      vim.keymap.set('n', 'g/', '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>')
    end

    if client.supports_method('textDocument/completion') then
      -- Supported on neovim v0.11 and up
      -- vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      -- vim.keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.completion.trigger()<cr>')
    end

    vim.api.nvim_buf_set_option(args.buf, 'signcolumn', 'yes')
  end
})
