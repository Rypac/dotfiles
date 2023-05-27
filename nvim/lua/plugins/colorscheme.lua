local colorscheme = function(opts)
  return {
    opts[1],
    name = opts.name,
    dependencies = {
      "echasnovski/mini.colors",
    },
    lazy = opts.lazy,
    priority = 1000,
    build = function()
      if opts.config then
        opts.config()
      end

      require("mini.colors")
        .get_colorscheme(opts.colorscheme, { new_name = "cterm-" .. opts.colorscheme })
        :add_cterm_attributes()
        :write()
    end,
    config = function()
      if opts.config then
        opts.config()
      end

      if vim.env.TERM_PROGRAM ~= "Apple_Terminal" then
        vim.cmd("colorscheme " .. opts.colorscheme)
      else
        require("mini.colors").get_colorscheme(opts.colorscheme):add_cterm_attributes():apply()
      end
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
    lazy = false,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
    end,
  }),
  colorscheme({
    "sainnhe/everforest",
    colorscheme = "everforest",
    lazy = true,
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_better_performance = 1
    end,
  }),
  colorscheme({
    "sainnhe/sonokai",
    colorscheme = "sonokai",
    lazy = true,
    config = function()
      vim.g.sonokai_style = "maia"
      vim.g.sonokai_better_performance = 1
    end,
  }),
}
