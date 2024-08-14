-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Move by visible lines
vim.keymap.set({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
vim.keymap.set({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Move lines
vim.keymap.set("n", "<C-j>", "<Cmd>m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<C-k>", "<Cmd>m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("x", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move line(s) down" })
vim.keymap.set("x", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move line(s) up" })

-- Clear search highlights
vim.keymap.set({ "i", "n" }, "<Esc>", "<Cmd>nohlsearch<CR><Esc>")

-- Format entire buffer
vim.keymap.set("n", "g=", "mqgggqG`q", { desc = "Format file" })

-- Navigation
vim.keymap.set("n", "]b", "<Cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "]B", "<Cmd>blast<CR>", { desc = "Last buffer" })
vim.keymap.set("n", "[B", "<Cmd>bfirst<CR>", { desc = "First buffer" })
vim.keymap.set("n", "]t", "<Cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "[t", "<Cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "]T", "<Cmd>tablast<CR>", { desc = "Last tab" })
vim.keymap.set("n", "[T", "<Cmd>tabfirst<CR>", { desc = "First tab" })

-- Option toggling
vim.keymap.set(
  "n",
  "<Leader>ob",
  '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"<CR><Cmd>set background?<CR>'
)
vim.keymap.set("n", "<Leader>oc", "<Cmd>setlocal cursorline! cursorline?<CR>")
vim.keymap.set("n", "<Leader>oh", "<Cmd>setlocal hlsearch! hlsearch?<CR>")
vim.keymap.set("n", "<Leader>oi", "<Cmd>setlocal ignorecase! ignorecase?<CR>")
vim.keymap.set("n", "<Leader>ol", "<Cmd>setlocal linebreak! linebreak?<CR>")
vim.keymap.set("n", "<Leader>on", "<Cmd>setlocal number! number?<CR>")
vim.keymap.set("n", "<Leader>or", "<Cmd>setlocal relativenumber! relativenumber?<CR>")
vim.keymap.set("n", "<Leader>os", "<Cmd>setlocal spell! spell?<CR>")
vim.keymap.set(
  "n",
  "<Leader>ot",
  "<Cmd>lua vim.o.showtabline = vim.o.showtabline == 1 and 2 or 1<CR>"
)
vim.keymap.set("n", "<Leader>ow", "<Cmd>setlocal wrap! wrap?<CR>")

-- Diagnostic
vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic in float" })
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, { desc = "Open quickfix list" })

-- LSP
vim.keymap.set("n", "gry", vim.lsp.buf.type_definition)
vim.keymap.set("n", "grY", vim.lsp.buf.implementation)
vim.keymap.set("n", "grr", vim.lsp.buf.references)
vim.keymap.set("n", "gri", vim.lsp.buf.incoming_calls)
vim.keymap.set("n", "gro", vim.lsp.buf.outgoing_calls)
vim.keymap.set("n", "grs", vim.lsp.buf.document_symbol)
vim.keymap.set("n", "grn", vim.lsp.buf.rename)
vim.keymap.set("n", "g.", vim.lsp.buf.code_action)
vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
vim.keymap.set(
  "n",
  "grt",
  "<Cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>"
)
