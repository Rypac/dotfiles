local map = vim.keymap.set

-- Move by visible lines
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Clear search highlights
map({ "i", "n" }, "<Esc>", "<Cmd>nohlsearch<CR><Esc>")

-- Format entire buffer
map("n", "g=", "<Cmd>Format<CR>", { desc = "Format buffer" })

-- Tab navigation
map("n", "]t", "<Cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "[t", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })
map("n", "]T", "<Cmd>tablast<CR>", { desc = "Last tab" })
map("n", "[T", "<Cmd>tabfirst<CR>", { desc = "First tab" })
for tab = 1, 9 do
  map("n", "<C-" .. tab .. ">", tab .. "gt", { desc = "Go to tab " .. tab })
  map("i", "<C-" .. tab .. ">", "<C-o>" .. tab .. "gt", { desc = "Go to tab " .. tab })
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
  map("n", "<Leader>o" .. key, "<Cmd>setlocal " .. option .. "! " .. option .. "?<CR>", {
    desc = "Toggle '" .. option .. "'",
  })
end
map(
  "n",
  "<Leader>ob",
  "<Cmd>lua vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'<CR><Cmd>set background?<CR>",
  { desc = "Toggle 'background'" }
)
map(
  "n",
  "<Leader>of",
  "<Cmd>lua vim.b.lsp_autoformat = vim.b.lsp_autoformat == false<CR>",
  { desc = "Toggle 'autoformat'" }
)
map(
  "n",
  "<Leader>os",
  "<Cmd>lua vim.o.signcolumn = vim.o.signcolumn == 'yes' and 'auto' or 'yes'<CR>",
  { desc = "Toggle 'signcolumn'" }
)
map(
  "n",
  "<Leader>ot",
  "<Cmd>lua vim.o.showtabline = vim.o.showtabline == 1 and 2 or 1<CR>",
  { desc = "Toggle 'tabline" }
)

-- Ftplugins
map("n", "<Leader>.", "<Cmd>Ftplugin<CR>", { desc = "Edit ftplugin for buffer filetype" })
