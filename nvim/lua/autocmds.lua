local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("HighlightYanks", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

autocmd("TermOpen", {
  desc = "Start builtin terminal in Insert mode and configure UI",
  group = augroup("TerminalOpen", { clear = true }),
  callback = function()
    vim.cmd("startinsert")
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
  end,
})

autocmd("FileType", {
  desc = "Start Git commits in Insert mode",
  group = augroup("GitCommit", { clear = true }),
  pattern = { "gitcommit", "gitrebase" },
  callback = function()
    vim.cmd("startinsert")
  end,
})

autocmd("FileType", {
  desc = "Automatically fold Haskell pragmas, exports and imports",
  group = augroup("HaskellFolds", { clear = true }),
  pattern = "haskell",
  callback = function()
    vim.cmd([[
      silent! normal! m`G
      silent! /\_^{-#\s\+LANGUAGE\s\+/normal! mlzf}``m`
      silent! /\_^module\s\+\_.\{-})\_.\{-}where\s*\_$/normal! mevgnzf``m`
      silent! /\_^import\s\+/normal! mizf}``m`
      silent! /\_^main\s\+=/normal! mm``m`
      let @/ = ""
    ]])
  end,
})

autocmd("FileType", {
  desc = "Automatically fold Java, Kotlin and Swift imports",
  group = augroup("ImportFolds", { clear = true }),
  pattern = { "java", "kotlin", "swift" },
  callback = function()
    vim.cmd([[
      silent! normal! m`G
      silent! /\_^import\s\+/normal! mizf}``m`
      let @/ = ""
    ]])
  end,
})
