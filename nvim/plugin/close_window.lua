vim.api.nvim_create_autocmd('FileType', {
  desc = 'Close windows with "q"',
  group = vim.api.nvim_create_augroup('CloseWithQ', { clear = true }),
  pattern = { 'help', 'checkhealth' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<Cmd>close<CR>', { buffer = event.buf, silent = true, desc = 'Quit buffer' })
  end
})
