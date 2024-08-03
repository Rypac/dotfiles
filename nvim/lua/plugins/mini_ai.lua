local ai = require('mini.ai')
ai.setup({
  custom_textobjects = {
    a = ai.gen_spec.treesitter({
      a = '@parameter.outer',
      i = '@parameter.inner'
    }),
    c = ai.gen_spec.treesitter({
      a = '@class.outer',
      i = '@class.inner'
    }),
    C = ai.gen_spec.treesitter({
      a = '@comment.outer',
      i = '@comment.inner'
    }),
    f = ai.gen_spec.treesitter({
      a = '@call.outer',
      i = '@call.inner'
    }),
    m = ai.gen_spec.treesitter({
      a = '@function.outer',
      i = '@function.inner'
    }),
    o = ai.gen_spec.treesitter({
      a = { '@conditional.outer', '@loop.outer' },
      i = { '@conditional.inner', '@loop.inner' }
    })
  }
})
