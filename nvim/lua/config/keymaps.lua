local map = vim.keymap.set

-- Move by visible lines
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Clear search highlights
map({ "i", "n" }, "<Esc>", "<Cmd>nohlsearch<CR><Esc>")

-- Format entire buffer
map("n", "g=", function()
  local saved_view = vim.fn.winsaveview()
  vim.cmd("normal! gggqG")
  vim.fn.winrestview(saved_view)
end, {
  desc = "Format file",
})

-- Buffer navigation
map("n", "]b", "<Cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "[b", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "]B", "<Cmd>blast<CR>", { desc = "Last buffer" })
map("n", "[B", "<Cmd>bfirst<CR>", { desc = "First buffer" })

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
map(
  "n",
  "<Leader>ob",
  "<Cmd>lua vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'<CR><Cmd>set background?<CR>"
)
map("n", "<Leader>oc", "<Cmd>setlocal cursorline! cursorline?<CR>")
map("n", "<Leader>oC", "<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>")
map("n", "<Leader>of", "<Cmd>lua vim.b.lsp_autoformat = vim.b.lsp_autoformat == false<CR>")
map("n", "<Leader>oh", "<Cmd>setlocal hlsearch! hlsearch?<CR>")
map("n", "<Leader>oi", "<Cmd>setlocal ignorecase! ignorecase?<CR>")
map("n", "<Leader>ol", "<Cmd>setlocal linebreak! linebreak?<CR>")
map("n", "<Leader>on", "<Cmd>setlocal number! number?<CR>")
map("n", "<Leader>or", "<Cmd>setlocal relativenumber! relativenumber?<CR>")
map(
  "n",
  "<Leader>os",
  "<Cmd>lua vim.o.signcolumn = vim.o.signcolumn == 'yes' and 'auto' or 'yes'<CR>"
)
map("n", "<Leader>ot", "<Cmd>lua vim.o.showtabline = vim.o.showtabline == 1 and 2 or 1<CR>")
map("n", "<Leader>ow", "<Cmd>setlocal wrap! wrap?<CR>")
map("n", "<Leader>oz", "<Cmd>setlocal spell! spell?<CR>")

-- Diagnostic
map("n", "<Leader>k", vim.diagnostic.open_float, { desc = "Open diagnostic in float" })

-- LSP
map("n", "g.", vim.lsp.buf.code_action)
map("n", "gra", vim.lsp.buf.code_action)
map("n", "grf", vim.lsp.buf.format)
map("n", "gri", vim.lsp.buf.incoming_calls)
map("n", "gro", vim.lsp.buf.outgoing_calls)
map("n", "grn", vim.lsp.buf.rename)
map("n", "grr", vim.lsp.buf.references)
map("n", "grs", vim.lsp.buf.document_symbol)
map("n", "grS", vim.lsp.buf.workspace_symbol)
map("n", "grt", "<Cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>")
map("n", "gry", vim.lsp.buf.type_definition)
map("n", "grI", vim.lsp.buf.implementation)

-- Ftplugins
map("n", "<Leader>.", "<Cmd>Ftplugin<CR>", { desc = "Edit ftplugin for buffer filetype" })
