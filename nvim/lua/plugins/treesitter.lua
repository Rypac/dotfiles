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
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']a'] = '@parameter.outer',
        [']c'] = '@class.outer',
        [']f'] = '@function.outer',
        [']o'] = { '@conditional.inner', '@conditional.outer' }
      },
      goto_next_end = {
        [']A'] = '@parameter.outer',
        [']C'] = '@class.outer',
        [']F'] = '@function.outer',
        [']O'] = { '@conditional.inner', '@conditional.outer' }
      },
      goto_previous_start = {
        ['[a'] = '@parameter.outer',
        ['[c'] = '@class.outer',
        ['[f'] = '@function.outer',
        ['[o'] = { '@conditional.inner', '@conditional.outer' }
      },
      goto_previous_end = {
        ['[A'] = '@parameter.outer',
        ['[C'] = '@class.outer',
        ['[F'] = '@function.outer',
        ['[O'] = { '@conditional.inner', '@conditional.outer' }
      }
    },
    swap = {
      enable = true,
      swap_next = {
        ['<Leader>aj'] = '@parameter.inner',
        ['<Leader>al'] = '@parameter.inner'
      },
      swap_previous = {
        ['<Leader>ak'] = '@parameter.inner',
        ['<Leader>ah'] = '@parameter.inner'
      }
    }
  }
})
