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
    vim.cmd([[
      silent! normal! m`G
      silent! /\_^{-#\s\+LANGUAGE\s\+/normal! mlzf}``m`
      silent! /\_^module\s\+\_.\{-})\_.\{-}where\s*\_$/normal! mevgnzf``m`
      silent! /\_^import\s\+/normal! mizf}``m`
      let @/ = ""
    ]])
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Automatically fold Java, Kotlin and Swift imports",
  pattern = { "java", "kotlin", "swift" },
  callback = function()
    vim.cmd([[
      silent! normal! m`G
      silent! /\_^import\s\+/normal! mizf}``m`
      let @/ = ""
    ]])
  end,
})
