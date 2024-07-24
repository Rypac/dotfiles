-- UI
vim.opt.breakindent = true
vim.opt.cursorline = false
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.ruler = false
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.termguicolors = vim.env.TERM_PROGRAM ~= "Apple_Terminal"

-- Editing
vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Folding
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.foldmethod = "manual"
vim.opt.foldminlines = 0
vim.opt.foldtext = "getline(v:foldstart)"

-- General
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.wildignore = { ".git/", "node_modules/" }
vim.opt.writebackup = false

-- Keybindings
vim.g.mapleader = " "

-- Search and replace
vim.keymap.set("v", "<C-r>", [["hy:%s/\V<C-r>h//g<left><left>]], { desc = "Replace selected text" })

-- Auto commands
vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Configure UI for builtin terminal",
  group = vim.api.nvim_create_augroup("ConfigureTerminal", { clear = true }),
  callback = function()
    vim.cmd("startinsert")
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = vim.api.nvim_create_augroup("HighlightYankedText", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- fzf
vim.opt.runtimepath:append("/opt/homebrew/opt/fzf")
vim.keymap.set("n", "<leader>e", "<cmd>FZF<cr>", { desc = "Fuzzy Finder" })

-- LSP
local start_lsp_group = vim.api.nvim_create_augroup("StartLSP", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  desc = "Start Haskell LSP",
  group = start_lsp_group,
  pattern = {"haskell", "lhaskell", "cabal"},
  callback = function()
    vim.lsp.start({
      name = "haskell-language-server",
      cmd = {"haskell-language-server-wrapper", "--lsp"},
      root_dir = vim.fs.root(0, {"hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml"}),
      init_options = {
        haskell = {
          formattingProvider = "fourmolu",
          cabalFormattingProvider = "cabal-gild",
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
  end
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Start Swift LSP",
  group = start_lsp_group,
  pattern = "swift",
  callback = function()
    vim.lsp.start({
      name = "swift-language-server",
      cmd = {"xcrun", "sourcekit-lsp"},
      root_dir = vim.fs.root(0, {"*.xcodeproj", "*.xcworkspace", "Package.swift"})
    })
  end
})
