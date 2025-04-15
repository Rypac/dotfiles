local sessions = require("mini.sessions")
sessions.setup()

vim.keymap.set("n", "<Leader>O", sessions.select, { desc = "Load session" })

local function session_name_completion(arg, _, _)
  local session_names = vim.tbl_map(function(session)
    return session.name
  end, sessions.detected)

  return vim.tbl_filter(function(name)
    return vim.startswith(name, arg)
  end, session_names)
end

vim.api.nvim_create_user_command("SessionLoad", function(opts)
  local session_name = opts.args
  local read_opts = { force = opts.bang }
  if session_name ~= "" then
    sessions.read(session_name, read_opts)
  else
    sessions.select("read", read_opts)
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
    sessions.write(session_name, write_opts)
  else
    sessions.write(nil, write_opts)
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

  sessions.write(nil, { force = true, verbose = false })
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
    sessions.delete(session_name, delete_opts)
  else
    sessions.select("delete", delete_opts)
  end
end, {
  desc = "Delete a session",
  bang = true,
  nargs = "?",
  complete = session_name_completion,
})
