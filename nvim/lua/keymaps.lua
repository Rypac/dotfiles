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

-- LSP
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition)
vim.keymap.set('n', 'gY', vim.lsp.buf.implementation)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
vim.keymap.set('n', 'gri', vim.lsp.buf.incoming_calls)
vim.keymap.set('n', 'gro', vim.lsp.buf.outgoing_calls)
vim.keymap.set('n', 'grs', vim.lsp.buf.document_symbol)
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'g<Space>', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grt', '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>')

