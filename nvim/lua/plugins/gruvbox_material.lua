vim.g.gruvbox_material_disable_italic_comment = 1

local current_theme = vim.o.background

for _, theme in ipairs({ 'dark', 'light' }) do
  vim.o.background = theme

  for _, background in ipairs({ 'hard', 'medium', 'soft' }) do
    vim.g.gruvbox_material_background = background

    for _, foreground in ipairs({ 'material', 'mix', 'original' }) do
      vim.g.gruvbox_material_foreground = foreground

      local name = 'gruvbox-' .. theme .. '-' .. background .. '-' .. foreground

      require('mini.colors')
        .get_colorscheme('gruvbox-material', { new_name = name })
        :add_cterm_attributes()
        :add_terminal_colors()
        :write()
    end
  end
end

vim.o.background = current_theme
