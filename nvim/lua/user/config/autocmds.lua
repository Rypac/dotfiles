local augroup = function(name)
  vim.api.nvim_create_augroup("User" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("HighlightYankedText"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = 'Close windows with "q"',
  group = augroup("CloseWithQ"),
  pattern = { "help", "checkhealth" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set(
      "n",
      "q",
      "<Cmd>close<CR>",
      { buffer = event.buf, silent = true, desc = "Quit buffer" }
    )
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  desc = "Resize splits on window resize",
  group = augroup("ResizeSplits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Configure UI for builtin terminal",
  group = augroup("ConfigureTerminal"),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert!")
  end,
})

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  desc = "Sync terminal background with colorscheme",
  group = augroup("SyncTerminalBackground"),
  callback = function()
    local normal = vim.api.nvim_get_hl_by_name("Normal", true)
    if normal.background ~= nil then
      io.write(string.format("\027]11;#%06x\027\\", normal.background))
    end
  end,
})

vim.api.nvim_create_autocmd("UILeave", {
  desc = "Reset terminal background",
  group = augroup("ResetTerminalBackground"),
  callback = function()
    io.write("\027]111\027\\")
  end,
})
