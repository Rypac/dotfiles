vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Start builtin terminal in Insert mode and configure UI",
  pattern = "*",
  callback = function()
    vim.cmd("startinsert")
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Automatically fold Haskell pragmas, exports and imports",
  pattern = "haskell",
  callback = function()
    vim.cmd("silent! 1/^{-# LANGUAGE /normal zfip")
    vim.cmd("silent! 1/^module /normal zfip")
    vim.cmd("silent! 1/^import /normal zfip")
    vim.cmd("let @/ = ''")
  end,
})
