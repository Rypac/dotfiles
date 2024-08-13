local pick = require("mini.pick")
pick.setup({
  source = {
    show = pick.default_show,
  },
  window = {
    config = function()
      height = math.floor(0.618 * vim.o.lines)
      width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = "NW",
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
})

vim.ui.select = pick.ui_select

pick.registry.config = function()
  return pick.builtin.files(nil, {
    source = {
      cwd = vim.fn.stdpath("config"),
    },
  })
end

vim.keymap.set("n", "<Leader><CR>", "<Cmd>Pick resume<CR>")
vim.keymap.set("n", "<Leader><Leader>", "<Cmd>Pick files<CR>")
vim.keymap.set("n", "<Leader>b", "<Cmd>Pick buffers<CR>")
vim.keymap.set("n", "<Leader>B", "<Cmd>Pick git_branches<CR>")
vim.keymap.set("n", "<Leader>c", "<Cmd>Pick commands<CR>")
vim.keymap.set("n", "<Leader>C", "<Cmd>Pick git_commits<CR>")
vim.keymap.set("n", "<Leader>d", "<Cmd>Pick diagnostic<CR>")
vim.keymap.set("n", "<Leader>f", "<Cmd>Pick grep_live<CR>")
vim.keymap.set("n", "<Leader>F", "<Cmd>Pick grep<CR>")
vim.keymap.set("n", "<Leader>gd", "<Cmd>Pick lsp scope='definition'<CR>")
vim.keymap.set("n", "<Leader>gD", "<Cmd>Pick lsp scope='declaration'<CR>")
vim.keymap.set("n", "<Leader>gr", "<Cmd>Pick lsp scope='references'<CR>")
vim.keymap.set("n", "<Leader>gi", "<Cmd>Pick lsp scope='implementation'<CR>")
vim.keymap.set("n", "<Leader>h", "<Cmd>Pick history scope=':'<CR>")
vim.keymap.set("n", "<Leader>H", "<Cmd>Pick git_hunks")
vim.keymap.set("n", "<Leader>k", "<Cmd>Pick keymaps<CR>")
vim.keymap.set("n", "<Leader>l", "<Cmd>Pick buf_lines scope='current'<CR>")
vim.keymap.set("n", "<Leader>L", "<Cmd>Pick buf_lines scope='all'<CR>")
vim.keymap.set("n", "<Leader>O", "<Cmd>Pick options<CR>")
vim.keymap.set("n", "<Leader>r", "<Cmd>Pick lsp scope='document_symbol'<CR>")
vim.keymap.set("n", "<Leader>R", "<Cmd>Pick lsp scope='workspace_symbol'<CR>")
vim.keymap.set("n", "<Leader>s", "<Cmd>Pick spellsuggest<CR>")
vim.keymap.set("n", "<Leader>t", "<Cmd>Pick treesitter<CR>")
vim.keymap.set("n", "<Leader>.", "<Cmd>Pick config<CR>")
vim.keymap.set("n", "<Leader>'", "<Cmd>Pick marks<CR>")
vim.keymap.set("n", '<Leader>"', "<Cmd>Pick registers<CR>")
vim.keymap.set("n", "<Leader>/", "<Cmd>Pick explorer<CR>")
vim.keymap.set("n", "<Leader>?", "<Cmd>Pick help<CR>")
