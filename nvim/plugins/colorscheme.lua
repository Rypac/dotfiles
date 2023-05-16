local colorscheme = function(opts)
  return {
    opts[1],
    name = opts.name,
    dependencies = {
      "echasnovski/mini.colors",
    },
    lazy = not (opts.enabled or false),
    priority = 1000,
    build = function()
      if opts.config then
        opts.config()
      end

      require("mini.colors")
        .get_colorscheme(opts.colorscheme, { new_name = "cterm-" .. opts.colorscheme })
        :add_cterm_attributes()
        :add_terminal_colors()
        :write()
    end,
    config = function()
      if vim.env.TERM_PROGRAM ~= "Apple_Terminal" then
        vim.opt.termguicolors = true
      end

      if opts.config then
        opts.config()
      end

      vim.cmd("colorscheme " .. opts.colorscheme)
    end,
  }
end

return {
  {
    "arcticicestudio/nord-vim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme nord]])
    end,
  },
  {
    "dracula/vim",
    name = "dracula",
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme dracula]])
    end,
  },
  colorscheme({
    "sainnhe/gruvbox-material",
    colorscheme = "gruvbox-material",
    enabled = true,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
    end,
  }),
  colorscheme({
    "sainnhe/everforest",
    colorscheme = "everforest",
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_better_performance = 1
    end,
  }),
  colorscheme({
    "sainnhe/sonokai",
    colorscheme = "sonokai",
    config = function()
      vim.g.sonokai_style = "maia"
      vim.g.sonokai_better_performance = 1
    end,
  }),
}
