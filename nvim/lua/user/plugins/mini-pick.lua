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

pick.registry.tabpages = function()
  local tabpages = vim.api.nvim_list_tabpages()

  return pick.start({
    source = {
      name = "Tabs",
      items = vim.tbl_map(function(tabpage)
        local tabpage_number = vim.api.nvim_tabpage_get_number(tabpage)
        local window = vim.api.nvim_tabpage_get_win(tabpage)
        local buffer = vim.api.nvim_win_get_buf(window)
        local name = vim.api.nvim_buf_get_name(buffer)
        return {
          text = string.format("%2d \0 %s", tabpage_number, name),
          bufnr = buffer,
          tabpage = tabpage,
        }
      end, tabpages),
      choose = function(item)
        if item ~= nil then
          vim.schedule(function()
            vim.api.nvim_set_current_tabpage(item.tabpage)
          end)
        end
      end,
    },
  })
end

for keymap, action in pairs({
  ["<Leader>"] = "files",
  ["<CR>"] = "resume",
  ["b"] = "buffers",
  ["B"] = "git_branches",
  ["C"] = "git_commits",
  ["d"] = "diagnostic scope='buffer'",
  ["D"] = "diagnostic scope='all'",
  ["f"] = "grep_live",
  ["F"] = "grep",
  ["gd"] = "lsp scope='definition'",
  ["gD"] = "lsp scope='declaration'",
  ["gi"] = "lsp scope='implementation'",
  ["gr"] = "lsp scope='references'",
  ["gs"] = "lsp scope='document_symbol'",
  ["gS"] = "lsp scope='workspace_symbol'",
  ["gy"] = "lsp scope='type_definition'",
  ["h"] = "history scope=':'",
  ["H"] = "git_hunks",
  ["j"] = "list scope='jump'",
  ["K"] = "keymaps",
  ["l"] = "buf_lines scope='current'",
  ["L"] = "buf_lines scope='all'",
  ["p"] = "files",
  ["P"] = "commands",
  ["q"] = "list scope='quickfix'",
  ["r"] = "lsp scope='document_symbol'",
  ["R"] = "lsp scope='workspace_symbol'",
  ["S"] = "options",
  ["t"] = "tabpages",
  ["x"] = "treesitter",
  [","] = "config",
  ["="] = "spellsuggest",
  ["'"] = "marks",
  ['"'] = "registers",
  ["/"] = "explorer",
  ["?"] = "help",
}) do
  vim.keymap.set("n", "<Leader>" .. keymap, "<Cmd>Pick " .. action .. "<CR>")
end
