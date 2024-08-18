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

local map_picker = function(keymap, action)
  vim.keymap.set("n", "<Leader>" .. keymap, "<Cmd>Pick " .. action .. "<CR>")
end

map_picker("<CR>", "resume")
map_picker("<Leader>", "files")
map_picker("b", "buffers")
map_picker("B", "git_branches")
map_picker("c", "commands")
map_picker("C", "git_commits")
map_picker("d", "diagnostic")
map_picker("f", "grep_live")
map_picker("F", "grep")
map_picker("gd", "lsp scope='definition'")
map_picker("gD", "lsp scope='declaration'")
map_picker("gr", "lsp scope='references'")
map_picker("gi", "lsp scope='implementation'")
map_picker("h", "history scope=':'")
map_picker("H", "git_hunks")
map_picker("k", "keymaps")
map_picker("l", "buf_lines scope='current'")
map_picker("L", "buf_lines scope='all'")
map_picker("O", "options")
map_picker("r", "lsp scope='document_symbol'")
map_picker("R", "lsp scope='workspace_symbol'")
map_picker("t", "treesitter")
map_picker("=", "spellsuggest")
map_picker(".", "config")
map_picker("'", "marks scope='global'")
map_picker('"', "registers")
map_picker("/", "explorer")
map_picker("?", "help")
