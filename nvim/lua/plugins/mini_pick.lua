local pick = require('mini.pick')
pick.setup({
  source = {
    show = pick.default_show
  },
  options = {
    content_from_bottom = true
  }
})

vim.ui.select = pick.ui_select

pick.registry.config = function()
  return pick.builtin.files(nil, {
    source = {
      cwd = vim.fn.stdpath('config')
    }
  })
end

vim.keymap.set('n', '<Leader><CR>', '<Cmd>Pick resume<CR>', { desc = 'Open last picker' })
vim.keymap.set('n', '<Leader><Leader>', '<Cmd>Pick files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<Leader>b', '<Cmd>Pick buffers<CR>', { desc = 'Find buffers' })
vim.keymap.set('n', '<Leader>B', '<Cmd>Pick git_branches<CR>', { desc = 'Find branches' })
vim.keymap.set('n', '<Leader>c', '<Cmd>Pick commands<CR>', { desc = 'Find commands' })
vim.keymap.set('n', '<Leader>C', '<Cmd>Pick git_commits<CR>', { desc = 'Find commits' })
vim.keymap.set('n', '<Leader>d', '<Cmd>Pick diagnostic<CR>', { desc = 'Find diagnostics' })
vim.keymap.set('n', '<Leader>f', '<Cmd>Pick grep_live<CR>', { desc = 'Find anything' })
vim.keymap.set('n', '<Leader>F', '<Cmd>Pick grep<CR>', { desc = 'Find anything' })
vim.keymap.set('n', '<Leader>gd', "<Cmd>Pick lsp scope='definition'<CR>", { desc = 'Find definition' })
vim.keymap.set('n', '<Leader>gD', "<Cmd>Pick lsp scope='declaration'<CR>", { desc = 'Find declaration' })
vim.keymap.set('n', '<Leader>gr', "<Cmd>Pick lsp scope='references'<CR>", { desc = 'Find references' })
vim.keymap.set('n', '<Leader>gi', "<Cmd>Pick lsp scope='implementation'<CR>", { desc = 'Find implementation' })
vim.keymap.set('n', '<Leader>h', "<Cmd>Pick history scope=':'<CR>", { desc = 'Find history' })
vim.keymap.set('n', '<Leader>H', '<Cmd>Pick git_hunks', { desc = 'Find hunks' })
vim.keymap.set('n', '<Leader>k', '<Cmd>Pick keymaps<CR>', { desc = 'Find keymaps' })
vim.keymap.set('n', '<Leader>l', "<Cmd>Pick buf_lines scope='current'<CR>", { desc = 'Find current buffer lines' })
vim.keymap.set('n', '<Leader>L', "<Cmd>Pick buf_lines scope='all'<CR>", { desc = 'Find open buffer lines' })
vim.keymap.set('n', '<Leader>O', '<Cmd>Pick options<CR>', { desc = 'Find options' })
vim.keymap.set('n', '<Leader>r', "<Cmd>Pick lsp scope='document_symbol'<CR>", { desc = 'Find document symbol' })
vim.keymap.set('n', '<Leader>R', "<Cmd>Pick lsp scope='workspace_symbol'<CR>", { desc = 'Find workspace symbol' })
vim.keymap.set('n', '<Leader>s', '<Cmd>Pick spellsuggest<CR>', { desc = 'Find spelling suggestions' })
vim.keymap.set('n', '<Leader>t', '<Cmd>Pick treesitter<CR>', { desc = 'Find treesitter nodes' })
vim.keymap.set('n', '<Leader>.', '<Cmd>Pick config<CR>', { desc = 'Find neovim configuration' })
vim.keymap.set('n', "<Leader>'", '<Cmd>Pick marks<CR>', { desc = 'Find marks' })
vim.keymap.set('n', '<Leader>"', '<Cmd>Pick registers<CR>', { desc = 'Find registers' })
vim.keymap.set('n', '<Leader>/', '<Cmd>Pick explorer<CR>', { desc = 'Find in file explorer' })
vim.keymap.set('n', '<Leader>/', '<Cmd>Pick explorer<CR>', { desc = 'Find in explorer' })
vim.keymap.set('n', '<Leader>?', '<Cmd>Pick help<CR>', { desc = 'Find help' })
