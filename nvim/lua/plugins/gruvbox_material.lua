vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'mix'
vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_better_performance = 1

if vim.env.TERM_PROGRAM ~= "Apple_Terminal" then
  vim.cmd('colorscheme gruvbox-material')
else
  if not pcall(vim.cmd, 'colorscheme gruvbox-' .. vim.o.background) then
    local original_background = vim.o.background

    for _, background in ipairs({ 'dark', 'light' }) do
      vim.o.background = background

      require('mini.colors')
        .get_colorscheme('gruvbox-material', { new_name = 'gruvbox-' .. background })
        :add_cterm_attributes()
        :add_terminal_colors()
        :write()
    end

    vim.o.background = original_background

    vim.cmd('colorscheme gruvbox-' .. vim.o.background)
  end
end
