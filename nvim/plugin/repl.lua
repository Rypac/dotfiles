vim.api.nvim_create_user_command("Repl", function(args)
  local buffer = vim.api.nvim_create_buf(true, true)

  if args.smods.tab ~= -1 then
    vim.cmd(args.smods.tab .. "tabnew")

    local window = vim.api.nvim_tabpage_get_win(0)
    vim.api.nvim_win_set_buf(window, buffer)
  else
    local opts = {
      vertical = args.smods.vertical,
    }

    if args.smods.split == "belowright" then
      opts.split = args.smods.vertical and "right" or "below"
    elseif args.smods.split == "aboveleft" then
      opts.split = args.smods.vertical and "left" or "above"
    elseif args.smods.split == "botright" then
      opts.split = args.smods.vertical and "right" or "below"
      opts.win = -1
    elseif args.smods.split == "topleft" then
      opts.split = args.smods.vertical and "left" or "above"
      opts.win = -1
    else
      opts.win = vim.api.nvim_get_current_win()
    end

    vim.api.nvim_open_win(buffer, true, opts)
  end

  local language = args.fargs[1] or vim.bo.filetype
  local command
  if #args.fargs > 1 then
    command = args.fargs
  elseif language == "haskell" or language == "cabal" then
    command = { "cabal", "repl" }
  elseif language == "swift" then
    command = { "swift", "repl" }
  elseif language == "python" then
    command = { "python3" }
  elseif language == "javascript" then
    command = { "node" }
  elseif language == "lua" then
    command = { "lua" }
  elseif language == "sqlite" then
    command = { "sqlite3" }
  else
    command = args.fargs
  end

  local channel_id = vim.fn.jobstart(command, { term = true })

  vim.api.nvim_create_autocmd("TermClose", {
    buffer = buffer,
    callback = function(args)
      vim.cmd("bdelete! " .. args.buf)
    end,
  })
end, {
  desc = "Start a repl for the given language",
  nargs = "*",
  complete = function()
    return { "haskell", "javascript", "lua", "python", "sqlite", "swift" }
  end,
})
