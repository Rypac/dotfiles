require("mini.visits").setup()

local make_select_path = function(select_global, recency_weight)
  local sort = MiniVisits.gen_sort.default({ recency_weight = recency_weight })
  local select_opts = { sort = sort }
  return function()
    local cwd = select_global and "" or vim.fn.getcwd()
    MiniVisits.select_path(cwd, select_opts)
  end
end

local map = function(lhs, desc, ...)
  vim.keymap.set("n", lhs, make_select_path(...), { desc = desc })
end

map("<Leader>vr", "Select recent (all)", true, 1)
map("<Leader>vR", "Select recent (cwd)", false, 1)
map("<Leader>vy", "Select frecent (all)", true, 0.5)
map("<Leader>vY", "Select frecent (cwd)", false, 0.5)
map("<Leader>vf", "Select frequent (all)", true, 0)
map("<Leader>vF", "Select frequent (cwd)", false, 0)

vim.keymap.set(
  "n",
  "<Leader>vl",
  "<Cmd>lua MiniVisits.select_label()<CR>",
  { desc = "Select label" }
)
vim.keymap.set(
  "n",
  "<Leader>vL",
  "<Cmd>lua MiniVisits.select_label('', '')<CR>",
  { desc = "Select label" }
)
vim.keymap.set("n", "<Leader>va", "<Cmd>lua MiniVisits.add_label()<CR>", { desc = "Add label" })

vim.keymap.set("n", "<Leader>vd", function()
  vim.ui.select(MiniVisits.list_labels(), {
    prompt = "Select a label to remove:",
  }, function(label)
    if label ~= nil then
      MiniVisits.remove_label(label)
    end
  end)
end, {
  desc = "Remove label",
})
