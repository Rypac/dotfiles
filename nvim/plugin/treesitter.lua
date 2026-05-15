vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("tree-sitter-enable", { clear = true }),
  callback = function(args)
    if vim.treesitter.language.add(args.match) then
      vim.treesitter.start(args.buf, args.match)

      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end,
})
