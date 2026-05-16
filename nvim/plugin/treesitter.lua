vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("tree-sitter-enable", { clear = true }),
  callback = function(args)
    if vim.treesitter.language.add(args.match) then
      vim.treesitter.start(args.buf, args.match)

      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = "expr"
      vim.wo[win][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end,
})
