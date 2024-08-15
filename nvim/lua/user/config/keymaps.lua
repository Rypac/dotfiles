local map = vim.keymap.set

-- Move by visible lines
map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Move lines
map("n", "<C-j>", "<Cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<C-k>", "<Cmd>m .-2<CR>==", { desc = "Move line up" })
map("x", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move line(s) down" })
map("x", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move line(s) up" })

-- Clear search highlights
map({ "i", "n" }, "<Esc>", "<Cmd>nohlsearch<CR><Esc>")

-- Format entire buffer
map("n", "g=", "mqgggqG`q", { desc = "Format file" })

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

-- Option toggling
map(
  "n",
  "<Leader>ob",
  '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"<CR><Cmd>set background?<CR>'
)
map("n", "<Leader>oc", "<Cmd>setlocal cursorline! cursorline?<CR>")
map("n", "<Leader>oC", "<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>")
map("n", "<Leader>oh", "<Cmd>setlocal hlsearch! hlsearch?<CR>")
map("n", "<Leader>oi", "<Cmd>setlocal ignorecase! ignorecase?<CR>")
map("n", "<Leader>ol", "<Cmd>setlocal linebreak! linebreak?<CR>")
map("n", "<Leader>on", "<Cmd>setlocal number! number?<CR>")
map("n", "<Leader>or", "<Cmd>setlocal relativenumber! relativenumber?<CR>")
map("n", "<Leader>os", "<Cmd>setlocal spell! spell?<CR>")
map("n", "<Leader>oS", "<Cmd>lua vim.o.signcolumn = vim.o.signcolumn == 'yes' and 'auto' or 'yes'<CR>")
map("n", "<Leader>ot", "<Cmd>lua vim.o.showtabline = vim.o.showtabline == 1 and 2 or 1<CR>")
map("n", "<Leader>ow", "<Cmd>setlocal wrap! wrap?<CR>")

-- Diagnostic
map("n", "<Leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic in float" })
map("n", "<Leader>q", vim.diagnostic.setloclist, { desc = "Open quickfix list" })

-- LSP
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
map("n", "grY", vim.lsp.buf.implementation)
