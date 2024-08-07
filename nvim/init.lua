-- [[ Options ]]

-- UI
vim.opt.breakindent = true
vim.opt.cursorline = false
vim.opt.linebreak = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.ruler = false
vim.opt.shortmess:append({ I = true })
vim.opt.showcmd = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.updatetime = 1000
vim.opt.wrap = false
vim.cmd('colorscheme retrobox')

-- Display whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Editing
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.infercase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

-- Folding
vim.opt.foldmethod = 'indent'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = ''
vim.opt.foldlevel = 99

-- Completions
vim.opt.completeopt = { 'menu', 'menuone', 'noinsert' }
vim.opt.shortmess:append({ c = true, C = true })

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- General
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.writebackup = false

-- [[ Keymaps ]]

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Move by visible lines
vim.keymap.set({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
vim.keymap.set({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Move lines
vim.keymap.set('n', '<C-j>', '<Cmd>m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<C-k>', '<Cmd>m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('x', '<C-j>', ":m '>+1<CR>gv=gv", { desc = 'Move line(s) down' })
vim.keymap.set('x', '<C-k>', ":m '<-2<CR>gv=gv", { desc = 'Move line(s) up' })

-- Clear search highlights
vim.keymap.set({ 'i', 'n' }, '<Esc>', '<Cmd>nohlsearch<CR><Esc>', { desc = 'Escape and clear search highlights' })

-- Format entire buffer
vim.keymap.set('n', 'g=', 'mqgggqG`q', { desc = 'Format file' })

-- Buffer navigation
vim.keymap.set('n', ']b', '<Cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '[b', '<Cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', ']B', '<Cmd>blast<CR>', { desc = 'Last buffer' })
vim.keymap.set('n', '[B', '<Cmd>bfirst<CR>', { desc = 'First buffer' })

-- Tab navigation
vim.keymap.set('n', ']t', '<Cmd>tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '[t', '<Cmd>tabprevious<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', ']T', '<Cmd>tablast<CR>', { desc = 'Last tab' })
vim.keymap.set('n', '[T', '<Cmd>tabfirst<CR>', { desc = 'First tab' })

-- Option toggling
vim.keymap.set('n', '<Leader>ob', '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"<CR>', { desc = 'Toggle "background"' })
vim.keymap.set('n', '<Leader>oc', '<Cmd>setlocal cursorline! cursorline?<CR>', { desc = 'Toggle "cursorline"' })
vim.keymap.set('n', '<Leader>oC', '<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>', { desc = 'Toggle "cursorcolumn"' })
vim.keymap.set('n', '<Leader>oh', '<Cmd>setlocal hlsearch! hlsearch?<CR>', { desc = 'Toggle search highlight' })
vim.keymap.set('n', '<Leader>oi', '<Cmd>setlocal ignorecase! ignorecase?<CR>', { desc = 'Toggle "ignorecase"' })
vim.keymap.set('n', '<Leader>ol', '<Cmd>setlocal linebreak! linebreak?<CR>', { desc = 'Toggle "linebreak"' })
vim.keymap.set('n', '<Leader>on', '<Cmd>setlocal number! number?<CR>', { desc = 'Toggle "number"' })
vim.keymap.set('n', '<Leader>or', '<Cmd>setlocal relativenumber! relativenumber?<CR>', { desc = 'Toggle "relativenumber"' })
vim.keymap.set('n', '<Leader>os', '<Cmd>setlocal spell! spell?<CR>', { desc = 'Toggle "spell"' })
vim.keymap.set('n', '<Leader>ot', '<Cmd>lua vim.o.showtabline = vim.o.showtabline == 1 and 2 or 1<CR>', { desc = 'Toggle "tabline"' })
vim.keymap.set('n', '<Leader>ow', '<Cmd>setlocal wrap! wrap?<CR>', { desc = 'Toggle "wrap"' })

-- Diagnostic
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostic information in float' })
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- LSP
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition)
vim.keymap.set('n', 'gY', vim.lsp.buf.implementation)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
vim.keymap.set('n', 'gri', vim.lsp.buf.incoming_calls)
vim.keymap.set('n', 'gro', vim.lsp.buf.outgoing_calls)
vim.keymap.set('n', 'grs', vim.lsp.buf.document_symbol)
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'g.', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grt', '<Cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>')

-- [[ Plugins ]]

if not pcall(require, 'plugins') then
  vim.notify('No plugins loaded', vim.log.levels.INFO)
end
