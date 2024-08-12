local ai = require("mini.ai")
local extra = require("mini.extra")
ai.setup({
  n_lines = 200,
  custom_textobjects = {
    a = ai.gen_spec.treesitter({
      a = "@parameter.outer",
      i = "@parameter.inner",
    }),
    c = ai.gen_spec.treesitter({
      a = "@class.outer",
      i = "@class.inner",
    }),
    f = ai.gen_spec.treesitter({
      a = "@function.outer",
      i = "@function.inner",
    }),
    o = ai.gen_spec.treesitter({
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }),
    u = ai.gen_spec.function_call(),
    i = extra.gen_ai_spec.indent(),
    e = extra.gen_ai_spec.buffer(),
    L = extra.gen_ai_spec.line(),
    D = extra.gen_ai_spec.diagnostic(),
    N = extra.gen_ai_spec.number(),
  },
})
