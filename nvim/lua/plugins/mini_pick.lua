require('mini.pick').setup({
  options = {
    content_from_bottom = true
  }
})

vim.keymap.set('n', '<leader><leader>', '<cmd>Pick files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>e', '<cmd>Pick files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>b', '<cmd>Pick buffers<cr>', { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>c', '<cmd>Pick cli<cr>', { desc = 'Find cli' })
vim.keymap.set('n', '<leader>h', '<cmd>Pick help<cr>', { desc = 'Find help' })
