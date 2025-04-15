local command = vim.api.nvim_create_user_command

command("ReloadConfig", function()
  for loaded_name, _ in pairs(package.loaded) do
    for _, target_package in ipairs({ "codecompanion", "mini", "nvim-treesitter" }) do
      if loaded_name:match("^" .. string.gsub(target_package, "%-", "%%%-")) then
        package.loaded[loaded_name] = nil
      end
    end
  end

  dofile(vim.env.MYVIMRC)

  vim.notify("Reloaded " .. vim.env.MYVIMRC, vim.log.levels.INFO)
end, {
  desc = "Reload neovim configuration",
})

command("Ftplugin", function(opts)
  local filetype = opts.args ~= "" and opts.args or vim.bo.filetype
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/after/ftplugin/" .. filetype .. ".lua")
end, {
  desc = "Edit configuration for the current filetype",
  nargs = "?",
  complete = "filetype",
})

command("Format", function()
  local saved_view = vim.fn.winsaveview()
  vim.cmd("normal! gggqG")
  vim.fn.winrestview(saved_view)
end, {
  desc = "Format the current buffer",
})

command("ApplyColorscheme", function(opts)
  vim.cmd("colorscheme " .. opts.args)

  if vim.env.TERM_PROGRAM == "Apple_Terminal" then
    require("mini.colors").get_colorscheme():add_cterm_attributes():add_terminal_colors():apply()
  end
end, {
  desc = "Apply colorscheme compatible with Terminal.app",
  nargs = "?",
  complete = "color",
})

command("Lazygit", function(opts)
  if opts.args ~= "" then
    vim.cmd("terminal lazygit " .. opts.args)
  else
    vim.cmd("terminal lazygit")
  end
end, {
  desc = "Open lazygit in a terminal",
  nargs = "*",
  complete = function(arg, _, _)
    return vim.tbl_filter(function(name)
      return vim.startswith(name, arg)
    end, { "status", "branch", "log", "stash" })
  end,
})

command("Tig", function(opts)
  if opts.args ~= "" then
    vim.cmd("terminal tig " .. opts.args)
  else
    vim.cmd("terminal tig")
  end
end, {
  desc = "Open tig in a terminal",
  nargs = "*",
  complete = function(arg, _, _)
    return vim.tbl_filter(function(name)
      return vim.startswith(name, arg)
    end, { "show", "reflog", "blame", "grep", "refs", "stash", "status" })
  end,
})
