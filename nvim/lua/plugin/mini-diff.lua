local diff = require("mini.diff")
diff.setup()

vim.keymap.set("n", "<Leader>G", diff.toggle_overlay, { desc = "Toggle diff overlay" })
