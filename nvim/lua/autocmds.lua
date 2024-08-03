-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('HighlightYankedText', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})
