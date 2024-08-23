local visits = require("mini.visits")
visits.setup({
  silent = true,
})

vim.keymap.set("n", "+", function()
  local has_bookmark = vim.tbl_contains(visits.list_labels(), "bookmark")
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
