return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register({
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>f"] = { name = "+find" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>h"] = { name = "+hunk" },
      ["<leader>ht"] = { name = "+toggle" },
      ["<leader>o"] = { name = "+option" },
      ["<leader>t"] = { name = "+tab" },
      ["<leader>x"] = { name = "+trouble" },
    })
  end,
}
