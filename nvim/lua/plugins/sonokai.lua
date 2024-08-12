vim.g.sonokai_disable_italic_comment = 1

for _, style in ipairs({ "default", "atlantis", "andromeda", "shusia", "maia", "espresso" }) do
  vim.g.sonokai_style = style

  require("mini.colors")
    .get_colorscheme("sonokai", { new_name = "sonokai-" .. style })
    :add_cterm_attributes()
    :add_terminal_colors()
    :write()
end
