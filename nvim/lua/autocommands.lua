-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('HighlightYankedText', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})

-- Configure terminal on open
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Configure UI for builtin terminal',
  group = vim.api.nvim_create_augroup('ConfigureTerminal', { clear = true }),
  callback = function()
    vim.cmd('startinsert')
    vim.opt_local.number = false
    vim.opt_local.signcolumn = 'no'
  end
})
