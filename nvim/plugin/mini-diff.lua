local diff = require("mini.diff")
diff.setup()

vim.keymap.set("n", "<Leader>G", function()
  diff.toggle_overlay()
end, {
  desc = "Diff overlay",
})
