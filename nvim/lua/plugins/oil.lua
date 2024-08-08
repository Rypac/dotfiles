require('oil').setup({
  view_options = {
    show_hidden = true
  }
})

vim.keymap.set('n', '<Leader>-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
