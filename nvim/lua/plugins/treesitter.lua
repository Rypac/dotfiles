require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'c',
    'comment',
    'css',
    'haskell',
    'html',
    'javascript',
    'json',
    'kotlin',
    'lua',
    'markdown',
    'markdown_inline',
    'proto',
    'python',
    'query',
    'rust',
    'sql',
    -- 'swift', -- Requires node to be installed
    'terraform',
    'toml',
    'vim',
    'vimdoc',
    'yaml'
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  }
})
