local files = require("mini.files")
files.setup({
  content = {
    prefix = function() end,
    filter = function(fs_entry)
      return files.config.options.show_hidden_files or not vim.startswith(fs_entry.name, ".")
    end,
  },
  mappings = {
    go_in = "",
    go_in_plus = "l",
    go_out = "h",
    go_out_plus = "",
  },
  options = {
    show_hidden_files = true,
  },
})

vim.keymap.set("n", "-", function()
  files.open(vim.api.nvim_buf_get_name(0))
end, {
  desc = "Open parent directory",
})

vim.keymap.set("n", "<Leader>~", function()
  files.open(nil, false)
end, {
  desc = "Open current working directory",
})

vim.api.nvim_create_autocmd("User", {
  desc = "Keys for mini.files window",
  pattern = "MiniFilesBufferCreate",
  group = vim.api.nvim_create_augroup("UserMiniFilesKeymap", { clear = true }),
  callback = function(args)
    vim.keymap.set("n", "-", function()
      for _ = 1, vim.v.count1 do
        files.go_out()
      end
    end, {
      desc = "Go out of directory",
      buffer = args.data.buf_id,
    })

    vim.keymap.set("n", "<CR>", function()
      for _ = 1, vim.v.count1 do
        files.go_in({ close_on_file = true })
      end
    end, {
      desc = "Go in entry",
      buffer = args.data.buf_id,
    })

    for _, lhs in ipairs({ "K", "<Tab>" }) do
      vim.keymap.set("n", lhs, function()
        files.config.windows.preview = not files.config.windows.preview
        files.refresh({
          windows = {
            preview = files.config.windows.preview,
          },
        })
      end, {
        desc = "Toggle preview",
        buffer = args.data.buf_id,
      })
    end

    vim.keymap.set("n", "g.", function()
      files.config.options.show_hidden_files = not files.config.options.show_hidden_files
      files.refresh({
        content = {
          force_update = true,
        },
      })
    end, {
      desc = "Toggle display of hidden files",
      buffer = args.data.buf_id,
    })

    local function map_split(lhs, split, desc)
      vim.keymap.set("n", lhs, function()
        local entry = files.get_fs_entry()
        if entry and entry.fs_type == "file" then
          files.close()
          vim.cmd(split .. " " .. entry.path)
        end
      end, {
        buffer = args.data.buf_id,
        desc = desc,
      })
    end

    for _, lhs in ipairs({ "<C-s>", "<C-w>s", "<C-w>S", "<C-w><C-s>" }) do
      map_split(lhs, "split", "Open in horizontal split")
    end
    for _, lhs in ipairs({ "<C-w>v", "<C-w><C-v>" }) do
      map_split(lhs, "vsplit", "Open in vertical split")
    end
    for _, lhs in ipairs({ "<C-t>", "<C-w>T" }) do
      map_split(lhs, "tabnew", "Open in new tabpage")
    end

    vim.keymap.set("n", "<C-;>", function()
      local entry = files.get_fs_entry()
      if not entry then
        return
      end

      local path
      if entry.fs_type == "file" then
        path = vim.fs.dirname(entry.path)
      else
        path = entry.paty
      end

      if path and vim.fn.isdirectory(path) ~= 0 then
        files.close()
        require("mini.pick").builtin.grep_live(nil, {
          source = {
            name = 'Search in "' .. vim.fs.basename(path) .. '"',
            cwd = path,
          },
        })
      end
    end, {
      desc = "Search in path",
      buffer = args.data.buf_id,
    })
  end,
})
