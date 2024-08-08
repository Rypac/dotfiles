vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'mix'
vim.g.gruvbox_material_disable_italic_comment = 1

local current_theme = vim.o.background

for _, theme in ipairs({ 'dark', 'light' }) do
  vim.o.background = theme

  require('mini.colors')
    .get_colorscheme('gruvbox-material', { new_name = 'gruvbox-' .. theme })
    :add_cterm_attributes()
    :add_terminal_colors()
    :write()
end

vim.o.background = current_theme
