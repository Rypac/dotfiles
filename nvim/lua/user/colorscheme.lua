local M = {}

M.apply = function(name)
  if vim.env.TERM_PROGRAM ~= "Apple_Terminal" then
    vim.cmd("colorscheme " .. name)
    return
  end

  local colorscheme_name = name .. "-" .. vim.o.background
  if not pcall(vim.cmd, "colorscheme " .. colorscheme_name) then
    M.write(name)
    vim.cmd("colorscheme " .. colorscheme_name)
  end
end

M.write = function(name)
  local original_background = vim.o.background

  for _, background in ipairs({ "dark", "light" }) do
    vim.o.background = background

    require("mini.colors")
      .get_colorscheme(name, { new_name = name .. "-" .. background })
      :add_cterm_attributes()
      :add_terminal_colors()
      :write()
  end

  vim.o.background = original_background
end

return M
