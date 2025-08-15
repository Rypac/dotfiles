local visits = require("mini.visits")
visits.setup()

vim.keymap.set("n", "<C-j>", function()
  require("mini.pick").registry.visit_paths_plus({ recency_weight = 1 })
end, {
  desc = "Select recent",
})

vim.keymap.set("n", "<C-k>", function()
  require("mini.pick").registry.visit_bookmarks()
end, {
  desc = "Select bookmark",
})

vim.keymap.set("n", "<C-0>", function()
  visits.iterate_paths("forward", nil, { filter = "bookmark", wrap = true })
end, {
  desc = "Cycle bookmarks",
})

vim.keymap.set("n", "<C-h>", function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    return
  end

  local silent = visits.config.silent
  visits.config.silent = true

  local cwd = vim.uv.cwd()
  local has_bookmark = #visits.list_labels(path, cwd, { filter = "bookmark" }) > 0
  if not has_bookmark then
    visits.add_label("bookmark", path, cwd)
  else
    visits.remove_label("bookmark", path, cwd)
  end

  visits.config.silent = silent
  vim.b.bookmark = not has_bookmark
  vim.cmd("redrawstatus")
end, {
  desc = "Toggle bookmark",
})

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
