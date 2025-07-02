local autocmd = vim.api.nvim_create_autocmd

local augroup = function(name)
  vim.api.nvim_create_augroup("User" .. name, { clear = true })
end

autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("HighlightYankedText"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("VimResized", {
  desc = "Resize splits on window resize",
  group = augroup("ResizeSplits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

autocmd("TermOpen", {
  desc = "Configure UI for builtin terminal",
  group = augroup("ConfigureTerminal"),
  callback = vim.schedule_wrap(function()
    vim.wo.number = false
    vim.wo.signcolumn = "no"
    vim.cmd("startinsert!")
  end),
})
