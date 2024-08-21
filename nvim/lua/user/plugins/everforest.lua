vim.g.everforest_background = "medium"
vim.g.everforest_better_performance = 1

if vim.env.TERM_PROGRAM ~= "Apple_Terminal" then
  vim.cmd("colorscheme everforest")
else
  if not pcall(vim.cmd, "colorscheme everforest-" .. vim.o.background) then
    local original_background = vim.o.background

    for _, background in ipairs({ "dark", "light" }) do
      vim.o.background = background

      require("mini.colors")
        .get_colorscheme("everforest", { new_name = "everforest-" .. background })
        :add_cterm_attributes()
        :add_terminal_colors()
        :write()
    end

    vim.o.background = original_background

    vim.cmd("colorscheme everforest-" .. vim.o.background)
  end
end
