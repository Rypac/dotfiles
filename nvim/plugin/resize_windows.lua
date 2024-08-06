vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Resize splits on window resize',
  group = vim.api.nvim_create_augroup('ResizeSplits', { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end
})
