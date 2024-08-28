local M = {}

M.apply = function(name)
  if vim.env.TERM_PROGRAM ~= "Apple_Terminal" then
    vim.cmd("colorscheme " .. name)
    return
  end

  if not pcall(vim.cmd, "colorscheme " .. name .. "-" .. vim.o.background) then
    local original_background = vim.o.background

    for _, background in ipairs({ "dark", "light" }) do
      vim.o.background = background

      require("mini.colors")
        .get_colorscheme("gruvbox-material", { new_name = name .. "-" .. background })
        :add_cterm_attributes()
        :add_terminal_colors()
        :write()
    end

    vim.o.background = original_background

    vim.cmd("colorscheme " .. name .. "-" .. vim.o.background)
  end
end

return M
