local pick = require("mini.pick")

local function picker_move_to_item(index)
  local home = vim.api.nvim_replace_termcodes("<Home>", true, false, true)
  local down = vim.api.nvim_replace_termcodes("<Down>", true, false, true)

  vim.api.nvim_feedkeys(home, "n", false)
  for _ = 1, index - 1 do
    vim.api.nvim_feedkeys(down, "n", false)
  end
end

local function select_item(index)
  return {
    char = "<C-" .. index .. ">",
    func = function()
      local matches = pick.get_picker_matches()
      if matches == nil then
        return
      end

      if index > #matches.all_inds then
        picker_move_to_item(matches.current_ind)
        return
      end

      picker_move_to_item(index)

      local choose_mapping = pick.config.mappings.choose or "<CR>"
      local choose = vim.api.nvim_replace_termcodes(choose_mapping, true, false, true)
      vim.api.nvim_feedkeys(choose, "n", false)
    end,
  }
end

local function search_path()
  return {
    char = "<C-;>",
    func = function()
      local matches = pick.get_picker_matches()
      if matches == nil or matches.current == nil then
        return
      end

      local path
      if type(matches.current) == "table" then
        path = matches.current.path
      else
        path = matches.current
      end

      if not path then
        return
      end

      if vim.fn.isdirectory(path) == 0 then
        path = vim.fs.dirname(path)
      end

      if vim.fn.isdirectory(path) == 0 then
        return
      end

      pick.builtin.grep_live(nil, {
        source = {
          name = 'Search in "' .. vim.fs.basename(path) .. '"',
          cwd = path,
        },
      })
    end,
  }
end

pick.setup({
  source = {
    show = pick.default_show,
  },
  window = {
    config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = "NW",
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
  mappings = {
    select_item_1 = select_item(1),
    select_item_2 = select_item(2),
    select_item_3 = select_item(3),
    select_item_4 = select_item(4),
    select_item_5 = select_item(5),
    select_item_6 = select_item(6),
    select_item_7 = select_item(7),
    select_item_8 = select_item(8),
    select_item_9 = select_item(9),
    search = search_path(),
  },
})

vim.ui.select = pick.ui_select

local function picker_remove_item(callback)
  local matches = pick.get_picker_matches()
  if not matches or matches.current == nil then
    return
  end

  if not callback(matches.current) then
    picker_move_to_item(matches.current_ind)
    return
  end

  local items = pick.get_picker_items()
  if not items then
    return
  end

  local updated_items = {}
  for index, item in ipairs(items) do
    if index ~= matches.current_ind then
      table.insert(updated_items, item)
    end
  end
  pick.set_picker_items(updated_items, { do_match = false })

  picker_move_to_item(math.min(matches.current_ind, #updated_items))
end

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
    mappings = {
      delete = {
        char = "<C-d>",
        func = function()
          picker_remove_item(function(match)
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

pick.registry.buffers_plus = function(local_opts, opts)
  return pick.builtin.buffers(
    local_opts,
    vim.tbl_deep_extend("force", opts or {}, {
      mappings = {
        wipeout = {
          char = "<C-d>",
          func = function()
            picker_remove_item(function(match)
              vim.api.nvim_buf_delete(match.bufnr, {})
              return true
            end)
          end,
        },
      },
    })
  )
end

pick.registry.marks_plus = function(local_opts, opts)
  local buffer = vim.api.nvim_get_current_buf()

  return require("mini.extra").pickers.marks(
    local_opts,
    vim.tbl_deep_extend("force", opts or {}, {
      mappings = {
        delete = {
          char = "<C-d>",
          func = function()
            picker_remove_item(function(match)
              local mark = string.sub(match.text, 1, 1)
              return vim.api.nvim_buf_del_mark(buffer, mark) or vim.api.nvim_del_mark(mark)
            end)
          end,
        },
      },
    })
  )
end

pick.registry.visit_bookmarks = function(local_opts, opts)
  local_opts = vim.tbl_deep_extend("force", local_opts or {}, { filter = "bookmark" })

  return require("mini.extra").pickers.visit_paths(
    local_opts,
    vim.tbl_deep_extend("force", opts or {}, {
      source = {
        name = local_opts.cwd ~= "" and "Bookmarks (cwd)" or "Bookmarks (all)",
      },
      mappings = {
        remove = {
          char = "<C-d>",
          func = function()
            picker_remove_item(function(path)
              require("mini.visits").remove_label("bookmark", path, local_opts.cwd)
              return true
            end)
          end,
        },
      },
    })
  )
end

pick.registry.visit_paths_plus = function(local_opts, opts)
  local_opts = local_opts or {}

  return require("mini.extra").pickers.visit_paths(
    local_opts,
    vim.tbl_deep_extend("force", opts or {}, {
      mappings = {
        remove = {
          char = "<C-d>",
          func = function()
            picker_remove_item(function(path)
              require("mini.visits").remove_path(path, local_opts.cwd)
              return true
            end)
          end,
        },
      },
    })
  )
end

pick.registry.visit_labels_plus = function(local_opts, opts)
  local_opts = local_opts or {}

  return require("mini.extra").pickers.visit_labels(
    local_opts,
    vim.tbl_deep_extend("force", opts or {}, {
      mappings = {
        remove = {
          char = "<C-d>",
          func = function()
            picker_remove_item(function(item)
              local picker_opts = pick.get_picker_opts()
              if not picker_opts then
                return false
              end

              local name = picker_opts.source.name
              if not name then
                return false
              end

              if string.match(name, "^Visit labels") ~= nil then
                require("mini.visits").remove_label(item, "", local_opts.cwd)
                return true
              end

              local _, label_start = string.find(name, '^Paths for "')
              local label_end, _ = string.find(name, '" label$')
              if label_start == nil or label_end == nil then
                return false
              end

              local label = string.sub(name, label_start + 1, label_end - 1)
              if label == "" then
                return false
              end

              require("mini.visits").remove_label(label, item, local_opts.cwd)
              return true
            end)
          end,
        },
      },
    })
  )
end

for keymap, action in pairs({
  ["<Leader>"] = { "files", desc = "Files" },
  ["b"] = { "buffers_plus", desc = "Buffers" },
  ["B"] = { "git_branches", desc = "Branches" },
  ["c"] = { "commands", desc = "Commands" },
  ["C"] = { "git_commits", desc = "Commits" },
  ["d"] = { "diagnostic scope='current'", desc = "Diagnostics (current)" },
  ["D"] = { "diagnostic scope='all'", desc = "Diagnostics (all)" },
  ["e"] = { "visit_paths_plus recency_weight=1", desc = "Recents (cwd)" },
  ["E"] = { "visit_paths_plus cwd='' recency_weight=1", desc = "Recents (all)" },
  ["f"] = { "grep_live", desc = "Grep" },
  ["h"] = { "history scope=':'", desc = "History" },
  ["H"] = { "git_hunks", desc = "Hunks" },
  ["j"] = { "list scope='jump'", desc = "Jumps" },
  ["K"] = { "keymaps", desc = "Keymaps" },
  ["ld"] = { "lsp scope='definition'", desc = "Definition" },
  ["lD"] = { "lsp scope='declaration'", desc = "Declaration" },
  ["li"] = { "lsp scope='implementation'", desc = "Implementation" },
  ["lr"] = { "lsp scope='references'", desc = "References" },
  ["ly"] = { "lsp scope='type_definition'", desc = "Type definition" },
  ["L"] = { "buf_lines scope='current'", desc = "Lines" },
  ["m"] = { "marks_plus scope='buf'", desc = "Marks (buffer)" },
  ["M"] = { "marks_plus scope='global'", desc = "Marks (global)" },
  ["O"] = { "options", desc = "Options" },
  ["q"] = { "list scope='quickfix'", desc = "Quickfix" },
  ["r"] = { "lsp scope='document_symbol'", desc = "Document symbols" },
  ["R"] = { "lsp scope='workspace_symbol'", desc = "Workspace symbols" },
  ["t"] = { "tabpages", desc = "Tabpages" },
  ["vl"] = { "visit_labels_plus", desc = "Labels (cwd)" },
  ["vL"] = { "visit_labels_plus cwd=''", desc = "Labels (all)" },
  ["vv"] = { "visit_paths_plus", desc = "Paths (cwd)" },
  ["vV"] = { "visit_paths_plus cwd=''", desc = "Paths (all)" },
  [","] = { "config", desc = "Config" },
  ["="] = { "spellsuggest", desc = "Spelling" },
  ["'"] = { "marks_plus", desc = "Marks" },
  ['"'] = { "registers", desc = "Registers" },
  ["/"] = { "explorer", desc = "Explorer" },
  ["?"] = { "help", desc = "Help" },
  ["\\"] = { "resume", desc = "Resume" },
}) do
  vim.keymap.set("n", "<Leader>" .. keymap, "<Cmd>Pick " .. action[1] .. "<CR>", { desc = action.desc })
end
