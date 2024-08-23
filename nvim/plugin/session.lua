if vim.g.loaded_user_session ~= nil then
  return
end
vim.g.loaded_user_session = 1

local function session_name_completion(arg, _, _)
  local session_names = vim.tbl_map(function(session)
    return session.name
  end, MiniSessions.detected)

  return vim.tbl_filter(function(name)
    return vim.startswith(name, arg)
  end, session_names)
end

vim.api.nvim_create_user_command("SessionLoad", function(opts)
  local session_name = opts.args
  local read_opts = { force = opts.bang }
  if session_name ~= "" then
    MiniSessions.read(session_name, read_opts)
  else
    MiniSessions.select("read", read_opts)
  end
end, {
  desc = "Load a session",
  bang = true,
  nargs = "?",
  complete = session_name_completion,
})

vim.api.nvim_create_user_command("SessionSave", function(opts)
  local session_name = opts.args
  local write_opts = { force = opts.bang }
  if session_name ~= "" then
    MiniSessions.write(session_name, write_opts)
  else
    MiniSessions.write(nil, write_opts)
  end
end, {
  desc = "Save a session",
  bang = true,
  nargs = "?",
  complete = session_name_completion,
})

vim.api.nvim_create_user_command("SessionClose", function(opts)
  if vim.v.this_session == "" then
    vim.notify("No session active")
    return
  end

  MiniSessions.write(nil, { force = true, verbose = false })
  vim.cmd("silent! %bwipeout" .. (opts.bang and "!" or ""))
  vim.v.this_session = ""

  vim.notify("Session closed")
end, {
  desc = "Close a session",
  bang = true,
})

vim.api.nvim_create_user_command("SessionDelete", function(opts)
  local session_name = opts.args
  local delete_opts = { force = opts.bang }
  if session_name ~= "" then
    MiniSessions.delete(session_name, delete_opts)
  else
    MiniSessions.select("delete", delete_opts)
  end
end, {
  desc = "Delete a session",
  bang = true,
  nargs = "?",
  complete = session_name_completion,
})
