vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Configure UI for builtin terminal',
  group = vim.api.nvim_create_augroup('ConfigureTerminal', { clear = true }),
  callback = function()
    vim.cmd('startinsert')
    vim.opt_local.number = false
    vim.opt_local.signcolumn = 'no'
  end
})

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
