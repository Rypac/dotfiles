local visits = require("mini.visits")
visits.setup({
  silent = true,
})

vim.keymap.set("n", "+", function()
  local has_bookmark = vim.list_contains(visits.list_labels(), "bookmark")
  if not has_bookmark then
    visits.add_label("bookmark")
  else
    visits.remove_label("bookmark")
  end

  vim.b.bookmark = not has_bookmark
  vim.cmd("redrawstatus")
end, {
  desc = "Toggle bookmark",
})

vim.keymap.set("n", "<C-0>", function()
  visits.iterate_paths("forward", nil, { filter = "bookmark", wrap = true })
end, {
  desc = "Cycle bookmarks",
})

vim.keymap.set("n", "_", "<Cmd>Pick visit_bookmarks<CR>", { desc = "Select bookmark" })

vim.keymap.set("n", "<Leader>va", function()
  visits.add_label()
end, {
  desc = "Add label (cwd)",
})

vim.keymap.set("n", "<Leader>vA", function()
  visits.add_label(nil, nil, "")
end, {
  desc = "Add label (all)",
})

vim.keymap.set("n", "<Leader>vd", function()
  visits.remove_label()
end, {
  desc = "Remove label (cwd)",
})

vim.keymap.set("n", "<Leader>vD", function()
  visits.remove_label(nil, nil, "")
end, {
  desc = "Remove label (all)",
})
