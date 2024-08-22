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

local function picker_move_to_item(index)
  local move_to_start = vim.api.nvim_replace_termcodes("<C-g>", true, false, true)
  vim.api.nvim_feedkeys(move_to_start, "n", false)

  local move_down = vim.api.nvim_replace_termcodes("<C-n>", true, false, true)
  for index = 1, index - 1 do
    vim.api.nvim_feedkeys(move_down, "n", false)
  end
end

local function picker_delete_item(callback)
  local matches = pick.get_picker_matches()
  if not callback(matches.current) then
    picker_move_to_item(matches.current_ind)
    return
  end

  local updated_items = {}
  for index, item in ipairs(pick.get_picker_items()) do
    if index ~= matches.current_ind then
      table.insert(updated_items, item)
    end
  end
  pick.set_picker_items(updated_items)

  picker_move_to_item(math.min(matches.current_ind, #updated_items))
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
    mappings = {
      delete = {
        char = "<C-d>",
        func = function()
          picker_delete_item(function(match)
            if match.tabpage == vim.api.nvim_get_current_tabpage() then
              return false
            end

            vim.cmd("tabclose " .. vim.api.nvim_tabpage_get_number(match.tabpage))
            return true
          end)
        end,
      },
    },
  })
end

local function buffers()
  pick.builtin.buffers(nil, {
    mappings = {
      wipeout = {
        char = "<C-d>",
        func = function()
          picker_delete_item(function(match)
            vim.api.nvim_buf_delete(match.bufnr, {})
            return true
          end)
        end,
      },
    },
  })
end

local function marks()
  local buffer = vim.api.nvim_get_current_buf()

  MiniExtra.pickers.marks(nil, {
    mappings = {
      delete = {
        char = "<C-d>",
        func = function()
          picker_delete_item(function(match)
            local mark = string.sub(match.text, 1, 1)
            return vim.api.nvim_buf_del_mark(buffer, mark) or vim.api.nvim_del_mark(mark)
          end)
        end,
      },
    },
  })
end

for keymap, action in pairs({
  ["<Leader>"] = "files",
  ["<CR>"] = "resume",
  ["b"] = buffers,
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
  ["'"] = marks,
  ['"'] = "registers",
  ["/"] = "explorer",
  ["?"] = "help",
}) do
  local lhs = "<Leader>" .. keymap
  local rhs = type(action) == "string" and "<Cmd>Pick " .. action .. "<CR>" or action
  vim.keymap.set("n", lhs, rhs)
end
