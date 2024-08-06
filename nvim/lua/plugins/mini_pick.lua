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

vim.keymap.set('n', '<Leader><CR>', '<cmd>Pick resume<cr>', { desc = 'Open last picker' })
vim.keymap.set('n', '<Leader><Leader>', '<cmd>Pick files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<Leader>b', '<cmd>Pick buffers<cr>', { desc = 'Find buffers' })
vim.keymap.set('n', '<Leader>B', '<cmd>Pick git_branches<cr>', { desc = 'Find branches' })
vim.keymap.set('n', '<Leader>c', '<cmd>Pick commands<cr>', { desc = 'Find commands' })
vim.keymap.set('n', '<Leader>C', '<cmd>Pick git_commits<cr>', { desc = 'Find commits' })
vim.keymap.set('n', '<Leader>d', '<cmd>Pick diagnostic<cr>', { desc = 'Find diagnostics' })
vim.keymap.set('n', '<Leader>e', '<cmd>Pick explorer<cr>', { desc = 'Find in explorer' })
vim.keymap.set('n', '<Leader>f', '<cmd>Pick grep_live<cr>', { desc = 'Find anything' })
vim.keymap.set('n', '<Leader>F', '<cmd>Pick grep<cr>', { desc = 'Find anything' })
vim.keymap.set('n', '<Leader>gd', "<cmd>Pick lsp scope='definition'<cr>", { desc = 'Find definition' })
vim.keymap.set('n', '<Leader>gD', "<cmd>Pick lsp scope='declaration'<cr>", { desc = 'Find declaration' })
vim.keymap.set('n', '<Leader>gr', "<cmd>Pick lsp scope='references'<cr>", { desc = 'Find references' })
vim.keymap.set('n', '<Leader>gi', "<cmd>Pick lsp scope='implementation'<cr>", { desc = 'Find implementation' })
vim.keymap.set('n', '<Leader>gs', "<cmd>Pick lsp scope='document_symbol'<cr>", { desc = 'Find document symbol' })
vim.keymap.set('n', '<Leader>gS', "<cmd>Pick lsp scope='workspace_symbol'<cr>", { desc = 'Find workspace symbol' })
vim.keymap.set('n', '<Leader>h', "<cmd>Pick history scope=':'<cr>", { desc = 'Find history' })
vim.keymap.set('n', '<Leader>H', '<cmd>Pick git_hunks', { desc = 'Find hunks' })
vim.keymap.set('n', '<Leader>k', '<cmd>Pick keymaps<cr>', { desc = 'Find keymaps' })
vim.keymap.set('n', '<Leader>l', "<cmd>Pick buf_lines scope='current'<cr>", { desc = 'Find current buffer lines' })
vim.keymap.set('n', '<Leader>L', "<cmd>Pick buf_lines scope='all'<cr>", { desc = 'Find open buffer lines' })
vim.keymap.set('n', '<Leader>O', '<cmd>Pick options<cr>', { desc = 'Find options' })
vim.keymap.set('n', '<Leader>s', '<cmd>Pick spellsuggest<cr>', { desc = 'Find spelling suggestions' })
vim.keymap.set('n', '<Leader>t', '<cmd>Pick treesitter<cr>', { desc = 'Find treesitter nodes' })
vim.keymap.set('n', '<Leader>.', '<cmd>Pick config<cr>', { desc = 'Find neovim configuration' })
vim.keymap.set('n', "<Leader>'", '<cmd>Pick marks<cr>', { desc = 'Find marks' })
vim.keymap.set('n', '<Leader>"', '<cmd>Pick registers<cr>', { desc = 'Find registers' })
vim.keymap.set('n', '<Leader>?', '<cmd>Pick help<cr>', { desc = 'Find help' })
