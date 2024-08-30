vim.api.nvim_create_user_command("Gstash", "Gllog -g stash", {
  desc = "Show git stash list",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fugitive",
  group = vim.api.nvim_create_augroup("UserFugitive", { clear = true }),
  callback = function(args)
    vim.keymap.set(
      "n",
      "czl",
      "<Cmd>Git --paginate stash list '--pretty=format:%h %as %<(10)%gd %s'<CR>",
      {
        desc = "Show git stash list",
        buffer = args.buf,
      }
    )
  end,
})
