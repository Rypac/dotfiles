-- UI
vim.opt.breakindent = true
vim.opt.cursorline = false
vim.opt.linebreak = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.ruler = false
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true
vim.opt.termguicolors = vim.env.TERM_PROGRAM ~= 'Apple_Terminal'
vim.opt.wrap = false
vim.cmd('colorscheme retrobox')

-- Editing
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.incsearch = true
vim.opt.infercase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

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
vim.cmd('filetype plugin indent on')

-- Keybindings
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Search and replace
vim.keymap.set('v', '<C-r>', [['hy:%s/\V<C-r>h//g<left><left>]], { desc = 'Replace selected text' })

-- Formatting
vim.keymap.set('n', '<leader>i', 'gg0VGgq', { desc = 'Format file' })

-- Option toggling
vim.keymap.set('n', '<leader>ob', '<cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"<cr>', { desc = 'Toggle "background"' })
vim.keymap.set('n', '<leader>oc', '<cmd>setlocal cursorline! cursorline?<cr>', { desc = 'Toggle "cursorline"' })
vim.keymap.set('n', '<leader>oC', '<cmd>setlocal cursorcolumn! cursorcolumn?<cr>', { desc = 'Toggle "cursorcolumn"' })
vim.keymap.set('n', '<leader>oh', '<cmd>setlocal hlsearch! hlsearch?<cr>', { desc = 'Toggle search highlight' })
vim.keymap.set('n', '<leader>oi', '<cmd>setlocal ignorecase! ignorecase?<cr>', { desc = 'Toggle "ignorecase"' })
vim.keymap.set('n', '<leader>ol', '<cmd>setlocal linebreak! linebreak?<cr>', { desc = 'Toggle "linebreak"' })
vim.keymap.set('n', '<leader>on', '<cmd>setlocal number! number?<cr>', { desc = 'Toggle "number"' })
vim.keymap.set('n', '<leader>or', '<cmd>setlocal relativenumber! relativenumber?<cr>', { desc = 'Toggle "relativenumber"' })
vim.keymap.set('n', '<leader>os', '<cmd>setlocal spell! spell?<cr>', { desc = 'Toggle "spell"' })
vim.keymap.set('n', '<leader>ot', '<cmd>lua vim.o.showtabline = vim.o.showtabline == 1 and 2 or 1<cr>', { desc = 'Toggle "tabline"' })
vim.keymap.set('n', '<leader>ow', '<cmd>setlocal wrap! wrap?<cr>', { desc = 'Toggle "wrap"' })

-- Terminal
vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Diagnostic
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- Auto commands
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Configure UI for builtin terminal',
  group = vim.api.nvim_create_augroup('ConfigureTerminal', { clear = true }),
  callback = function()
    vim.cmd('startinsert')
    vim.opt_local.number = false
    vim.opt_local.signcolumn = 'no'
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = vim.api.nvim_create_augroup('HighlightYankedText', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- fzf
vim.opt.runtimepath:append('/opt/homebrew/opt/fzf')
vim.keymap.set('n', '<leader>e', '<cmd>FZF<cr>', { desc = 'Fuzzy Finder' })
vim.keymap.set('n', '<leader><leader>', '<cmd>FZF<cr>', { desc = 'Fuzzy Finder' })

-- LSP
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Start Haskell LSP',
  group = vim.api.nvim_create_augroup('StartHaskellLsp', { clear = true }),
  pattern = {'haskell', 'lhaskell', 'cabal'},
  callback = function()
    vim.lsp.start({
      name = 'haskell-language-server',
      cmd = {'haskell-language-server-wrapper', '--lsp'},
      root_dir = vim.fs.root(0, {'hie.yaml', 'stack.yaml', 'cabal.project', '*.cabal', 'package.yaml'}),
      init_options = {
        haskell = {
          formattingProvider = 'fourmolu',
          cabalFormattingProvider = 'cabal-gild',
          plugin = {
            rename = {
              config = {
                crossModule = true
              }
            }
          }
        }
      }
    })

    vim.opt_local.signcolumn = 'yes'
  end
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Start Swift LSP',
  group = vim.api.nvim_create_augroup('StartSwiftLsp', { clear = true }),
  pattern = 'swift',
  callback = function()
    vim.lsp.start({
      name = 'swift-language-server',
      cmd = {'xcrun', 'sourcekit-lsp'},
      root_dir = vim.fs.root(0, {'*.xcodeproj', '*.xcworkspace', 'Package.swift'})
    })

    vim.opt_local.signcolumn = 'yes'
  end
})
