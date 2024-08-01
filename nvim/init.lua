-- UI
vim.opt.breakindent = true
vim.opt.cursorline = false
vim.opt.linebreak = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.ruler = false
vim.opt.shortmess:append({ I = true })
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true
vim.opt.wrap = false
vim.cmd('colorscheme retrobox')

-- Editing
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.infercase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

-- Completions
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess:append({ c = true })

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Folding
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'manual'
vim.opt.foldminlines = 0
vim.opt.foldtext = 'getline(v:foldstart)'

-- General
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.wildignore = { '.git/', 'node_modules/' }
vim.opt.writebackup = false

-- Keybindings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlights' })

-- Open completion popup
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { desc = 'Clear search highlights' })

-- Search and replace
vim.keymap.set('v', '<C-r>', [['hy:%s/\V<C-r>h//g<left><left>]], { desc = 'Replace selected text' })

-- Formatting
vim.keymap.set('n', 'g=', 'gggqG', { desc = 'Format file' })
vim.keymap.set('v', 'g=', 'gq', { desc = 'Format selection' })

-- Buffers
vim.keymap.set('n', 'gb', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', 'gB', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })

-- Square bracket navigation
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', ']B', '<cmd>blast<cr>', { desc = 'Last buffer' })
vim.keymap.set('n', '[B', '<cmd>bfirst<cr>', { desc = 'First buffer' })
vim.keymap.set('n', ']t', '<cmd>tabnext<cr>', { desc = 'Next tab' })
vim.keymap.set('n', '[t', '<cmd>tabprevious<cr>', { desc = 'Previous tab' })
vim.keymap.set('n', ']T', '<cmd>tablast<cr>', { desc = 'Last tab' })
vim.keymap.set('n', '[T', '<cmd>tabfirst<cr>', { desc = 'First tab' })

-- Option toggling
vim.keymap.set('n', '<Leader>ob', '<cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"<cr>', { desc = 'Toggle "background"' })
vim.keymap.set('n', '<Leader>oc', '<cmd>setlocal cursorline! cursorline?<cr>', { desc = 'Toggle "cursorline"' })
vim.keymap.set('n', '<Leader>oC', '<cmd>setlocal cursorcolumn! cursorcolumn?<cr>', { desc = 'Toggle "cursorcolumn"' })
vim.keymap.set('n', '<Leader>oh', '<cmd>setlocal hlsearch! hlsearch?<cr>', { desc = 'Toggle search highlight' })
vim.keymap.set('n', '<Leader>oi', '<cmd>setlocal ignorecase! ignorecase?<cr>', { desc = 'Toggle "ignorecase"' })
vim.keymap.set('n', '<Leader>ol', '<cmd>setlocal linebreak! linebreak?<cr>', { desc = 'Toggle "linebreak"' })
vim.keymap.set('n', '<Leader>on', '<cmd>setlocal number! number?<cr>', { desc = 'Toggle "number"' })
vim.keymap.set('n', '<Leader>or', '<cmd>setlocal relativenumber! relativenumber?<cr>', { desc = 'Toggle "relativenumber"' })
vim.keymap.set('n', '<Leader>os', '<cmd>setlocal spell! spell?<cr>', { desc = 'Toggle "spell"' })
vim.keymap.set('n', '<Leader>ot', '<cmd>lua vim.o.showtabline = vim.o.showtabline == 1 and 2 or 1<cr>', { desc = 'Toggle "tabline"' })
vim.keymap.set('n', '<Leader>ow', '<cmd>setlocal wrap! wrap?<cr>', { desc = 'Toggle "wrap"' })

-- Diagnostic
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- Auto commands
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('HighlightYankedText', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Configure UI for builtin terminal',
  group = vim.api.nvim_create_augroup('ConfigureTerminal', { clear = true }),
  callback = function()
    vim.cmd('startinsert')
    vim.opt_local.number = false
    vim.opt_local.signcolumn = 'no'
  end
})

-- FZF
vim.opt.runtimepath:append('/opt/homebrew/opt/fzf')

vim.keymap.set('n', '<Leader>e', '<cmd>FZF<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<Leader><Leader>', '<cmd>FZF<cr>', { desc = 'Find files' })
