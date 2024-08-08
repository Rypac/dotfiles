require('mini.colors').setup()

vim.api.nvim_create_user_command(
  'GenerateColorscheme',
  function(opts)
    local name = opts.args

    require('mini.colors')
      .get_colorscheme(name, { new_name = 'mini-' .. name })
      :add_cterm_attributes()
      :add_terminal_colors()
      :write()
  end,
  {
    desc = 'Generate a cterm compatible colorscheme with mini.colors',
    complete = 'color',
    nargs = 1
  }
)
