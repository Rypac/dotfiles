require("mini.deps").add("tpope/vim-fugitive")

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

vim.keymap.set("n", "<Leader>gb", "<Cmd>Git blame<CR>", { desc = "Blame" })
vim.keymap.set("n", "<Leader>gb", "<Cmd>Git blame<CR>", { desc = "Blame" })
vim.keymap.set("n", "<Leader>gd", "<Cmd>Gdiffsplit<CR>", { desc = "Diff (split)" })
vim.keymap.set("n", "<Leader>gD", "<Cmd>tab Gdiffsplit<CR>", { desc = "Diff (tab)" })
vim.keymap.set("n", "<Leader>gf", "<Cmd>Git log --oneline %<CR>", { desc = "Log file (split)" })
vim.keymap.set("n", "<Leader>gF", "<Cmd>tab Git log --oneline %<CR>", { desc = "Log file (tab)" })
vim.keymap.set("n", "<Leader>gg", "<Cmd>Lazygit<CR>", { desc = "Lazygit" })
vim.keymap.set("n", "<Leader>gl", "<Cmd>Git log --oneline<CR>", { desc = "Log (split)" })
vim.keymap.set("n", "<Leader>gL", "<Cmd>tab Git log --oneline<CR>", { desc = "Log (tab)" })
vim.keymap.set("n", "<Leader>go", "<Cmd>GBrowse<CR>", { desc = "Browse" })
vim.keymap.set("n", "<Leader>gm", "<Cmd>Git mergetool<CR>", { desc = "Mergetool" })
vim.keymap.set("n", "<Leader>gs", "<Cmd>Git<CR>", { desc = "Status" })
vim.keymap.set("n", "<Leader>gt", "<Cmd>Tig<CR>", { desc = "Tig" })
