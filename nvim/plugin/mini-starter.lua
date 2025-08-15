local starter = require("mini.starter")
starter.setup()

vim.keymap.set("n", "<Leader>S", function()
  starter.open()
end, {
  desc = "Start screen",
})
