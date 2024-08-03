vim.api.nvim_create_autocmd('TermClose', {
  desc = 'Clear terminal on exiting TUI apps',
  pattern = { 'term://*lazygit', 'term://*tig' },
  group = vim.api.nvim_create_augroup('CleanupTerminal', { clear = true }),
  callback = function(args)
    vim.cmd('bdelete! ' .. args.buf)
  end
})

vim.api.nvim_create_user_command(
  'Lazygit',
  'terminal lazygit',
  {
    desc = 'Open lazygit in a terminal'
  }
)

vim.api.nvim_create_user_command(
  'Tig',
  'terminal tig',
  {
    desc = 'Open tig in a terminal'
  }
)
