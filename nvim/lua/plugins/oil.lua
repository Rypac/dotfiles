require('oil').setup({
  skip_confirm_for_simple_edits = true,
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name, bufnr)
      return name == '..'
    end
  }
})

vim.keymap.set('n', '<Leader>-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
