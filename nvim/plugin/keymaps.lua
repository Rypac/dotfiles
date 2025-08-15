-- Move by visible lines
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Clear search highlights
vim.keymap.set({ "i", "n" }, "<Esc>", "<Cmd>nohlsearch<CR><Esc>")

-- System clipboard
vim.keymap.set("x", "<Leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("n", "<Leader>y", '"+yy', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "x" }, "<Leader>p", '"+p', { desc = "Paste from clipboard" })

-- Search in visual selection
vim.keymap.set("n", "<C-/>", "/\\%V", { desc = "Search in selection" })
vim.keymap.set("x", "<C-/>", "<Esc>/\\%V", { desc = "Search in selection" })

-- Tab navigation
vim.keymap.set("n", "]t", "<Cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "[t", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "]T", "<Cmd>tablast<CR>", { desc = "Last tab" })
vim.keymap.set("n", "[T", "<Cmd>tabfirst<CR>", { desc = "First tab" })
for tab = 1, 9 do
  vim.keymap.set("n", "<C-" .. tab .. ">", tab .. "gt", { desc = "Go to tab " .. tab })
  vim.keymap.set("i", "<C-" .. tab .. ">", "<C-o>" .. tab .. "gt", { desc = "Go to tab " .. tab })
end

-- Option toggling
for key, option in pairs({
  c = "cursorline",
  C = "cursorcolumn",
  h = "hlsearch",
  i = "ignorecase",
  l = "linebreak",
  n = "number",
  r = "relativenumber",
  w = "wrap",
  z = "spell",
}) do
  vim.keymap.set("n", "<Leader>o" .. key, "<Cmd>setlocal " .. option .. "! " .. option .. "?<CR>", {
    desc = "Toggle '" .. option .. "'",
  })
end
vim.keymap.set(
  "n",
  "<Leader>ob",
  "<Cmd>lua vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'<CR><Cmd>set background?<CR>",
  { desc = "Toggle 'background'" }
)
vim.keymap.set(
  "n",
  "<Leader>of",
  "<Cmd>lua vim.b.lsp_autoformat = vim.b.lsp_autoformat == false<CR>",
  { desc = "Toggle 'autoformat'" }
)
vim.keymap.set(
  "n",
  "<Leader>os",
  "<Cmd>lua vim.o.signcolumn = vim.o.signcolumn == 'yes' and 'auto' or 'yes'<CR>",
  { desc = "Toggle 'signcolumn'" }
)
vim.keymap.set(
  "n",
  "<Leader>ot",
  "<Cmd>lua vim.o.showtabline = vim.o.showtabline == 1 and 2 or 1<CR>",
  { desc = "Toggle 'tabline" }
)
