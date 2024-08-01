vim.opt.runtimepath:append('/opt/homebrew/opt/fzf')

vim.keymap.set('n', '<Leader>e', '<cmd>FZF<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<Leader><Leader>', '<cmd>FZF<cr>', { desc = 'Find files' })
