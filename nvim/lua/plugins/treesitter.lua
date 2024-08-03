require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'c',
    'comment',
    'css',
    'haskell',
    'html',
    'java',
    'javascript',
    'json',
    'kotlin',
    'lua',
    'markdown',
    'markdown_inline',
    'proto',
    'python',
    'query',
    'regex',
    'rust',
    'sql',
    -- 'swift',
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
