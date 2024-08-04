require('mini.pick').setup({
  options = {
    content_from_bottom = true
  }
})

vim.keymap.set('n', '<Leader><Leader>', '<cmd>Pick files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<Leader>b', '<cmd>Pick buffers<cr>', { desc = 'Find buffers' })
vim.keymap.set('n', '<Leader>c', '<cmd>Pick commands<cr>', { desc = 'Find commands' })
vim.keymap.set('n', '<Leader>d', '<cmd>Pick diagnostic<cr>', { desc = 'Find diagnostics' })
vim.keymap.set('n', '<Leader>e', '<cmd>Pick explorer<cr>', { desc = 'Find in explorer' })
vim.keymap.set('n', '<Leader>f', '<cmd>Pick grep_live<cr>', { desc = 'Find anything' })
vim.keymap.set('n', '<Leader>gd', "<cmd>Pick lsp scope='definition'<cr>", { desc = 'Find definition' })
vim.keymap.set('n', '<Leader>gD', "<cmd>Pick lsp scope='declaration'<cr>", { desc = 'Find declaration' })
vim.keymap.set('n', '<Leader>gr', "<cmd>Pick lsp scope='references'<cr>", { desc = 'Find references' })
vim.keymap.set('n', '<Leader>gi', "<cmd>Pick lsp scope='implementation'<cr>", { desc = 'Find implementation' })
vim.keymap.set('n', '<Leader>gs', "<cmd>Pick lsp scope='document_symbol'<cr>", { desc = 'Find document symbol' })
vim.keymap.set('n', '<Leader>gS', "<cmd>Pick lsp scope='workspace_symbol'<cr>", { desc = 'Find workspace symbol' })
vim.keymap.set('n', '<Leader>h', "<cmd>Pick history scope=':'<cr>", { desc = 'Find history' })
vim.keymap.set('n', '<Leader>k', '<cmd>Pick keymaps<cr>', { desc = 'Find keymaps' })
vim.keymap.set('n', '<Leader>l', '<cmd>Pick buf_lines<cr>', { desc = 'Find buffer lines' })
vim.keymap.set('n', '<Leader>m', '<cmd>Pick marks<cr>', { desc = 'Find marks' })
vim.keymap.set('n', '<Leader>o', '<cmd>Pick options<cr>', { desc = 'Find options' })
vim.keymap.set('n', '<Leader>r', '<cmd>Pick registers<cr>', { desc = 'Find registers' })
vim.keymap.set('n', '<Leader>s', '<cmd>Pick spellsuggest<cr>', { desc = 'Find spelling suggestions' })
vim.keymap.set('n', '<Leader>t', '<cmd>Pick treesitter<cr>', { desc = 'Find treesitter nodes' })
vim.keymap.set('n', '<Leader>?', '<cmd>Pick help<cr>', { desc = 'Find help' })
