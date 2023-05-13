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
        .get_colorscheme(opts.colorscheme, { new_name = "custom-" .. opts.colorscheme })
        :add_cterm_attributes()
        :add_terminal_colors()
        :write()
    end,
    config = function()
      if opts.config then
        opts.config()
      end

      if vim.env.TERM_PROGRAM == "Apple_Terminal" then
        vim.cmd("colorscheme custom-" .. opts.colorscheme)
      else
        vim.cmd("colorscheme " .. opts.colorscheme)
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
    "navarasu/onedark.nvim",
    colorscheme = "onedark",
  }),
  colorscheme({
    "shaunsingh/nord.nvim",
    colorscheme = "nord",
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_italic = false
    end,
  }),
  colorscheme({
    "sainnhe/gruvbox-material",
    colorscheme = "gruvbox-material",
    enabled = true,
    config = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_statusline_style = "mix"
    end,
  }),
  colorscheme({
    "catppuccin/nvim",
    name = "catppuccin",
    colorscheme = "catppuccin",
  }),
  colorscheme({
    "EdenEast/nightfox.nvim",
    colorscheme = "nightfox",
  }),
  colorscheme({
    "sainnhe/everforest",
    colorscheme = "everforest",
  }),
  colorscheme({
    "rebelot/kanagawa.nvim",
    colorscheme = "kanagawa",
  }),
}
