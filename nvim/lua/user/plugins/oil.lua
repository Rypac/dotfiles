local oil = require("oil")
oil.setup({
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, bufnr)
      return name == ".."
    end,
  },
})

vim.keymap.set("n", "-", function()
  oil.open()
end, {
  desc = "Open parent directory",
})

vim.keymap.set("n", "<Leader>-", function()
  oil.toggle_float()
end, {
  desc = "Open parent directory in floating window",
})

vim.keymap.set("n", "<Leader>~", function()
  oil.open(vim.uv.cwd())
end, {
  desc = "Open current working directory",
})
