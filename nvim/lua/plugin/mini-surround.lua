require("mini.surround").setup({
  mappings = {
    add = "ys",
    delete = "ds",
    find = "",
    find_left = "",
    highlight = "",
    replace = "cs",
    update_n_lines = "",
    suffix_last = "",
    suffix_next = "",
  },
  search_method = "cover_or_next",
})

vim.keymap.del("x", "ys")
vim.keymap.set("n", "yss", "ys_", { remap = true })
vim.keymap.set("x", "S", [[:<C-u>lua require("mini.surround").add("visual")<CR>]], {
  silent = true,
})
