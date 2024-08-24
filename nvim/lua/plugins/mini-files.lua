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

vim.keymap.set("n", "<Leader>-", function()
  files.open()
end, {
  desc = "Open current working directory in last used state",
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
        if entry.fs_type == "file" then
          files.close()
          vim.cmd(split .. " " .. entry.path)
        end
      end, {
        buffer = args.data.buf_id,
        desc = desc,
      })
    end

    map_split("gs", "split", "Open in horizontal split")
    map_split("gv", "vsplit", "Open in vertical split")
    map_split("gt", "tabnew", "Open in new tabpage")
  end,
})
