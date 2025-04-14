local jump2d = require("mini.jump2d")
jump2d.setup({
  mappings = {
    start_jumping = "",
  },
})

vim.keymap.set({ "n", "v" }, "s", function()
  jump2d.start(jump2d.builtin_opts.single_character)
end, {
  desc = "Jump to single character",
})
