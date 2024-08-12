local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.deps"
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.deps`" | redraw')
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.deps",
    mini_path,
  })
  vim.cmd("packadd mini.deps | helptags ALL")
  vim.cmd('echo "Installed `mini.deps`" | redraw')
end

require("mini.deps").setup({
  path = {
    package = path_package,
  },
})

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add("echasnovski/mini.statusline")
  require("plugins.mini_statusline")
end)

now(function()
  add("sainnhe/gruvbox-material")
  add("echasnovski/mini.colors")
  require("plugins.gruvbox_material")
end)

later(function()
  add("echasnovski/mini.ai")
  add("echasnovski/mini.extra")
  require("plugins.mini_ai")
end)

later(function()
  add("echasnovski/mini.pick")
  add("echasnovski/mini.extra")
  require("plugins.mini_pick")
end)

later(function()
  add("echasnovski/mini.splitjoin")
  require("plugins.mini_splitjoin")
end)

later(function()
  add("echasnovski/mini.surround")
  require("plugins.mini_surround")
end)

later(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "master",
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
  })
  add("nvim-treesitter/nvim-treesitter-textobjects")
  require("plugins.treesitter")
end)

later(function()
  add("stevearc/oil.nvim")
  require("plugins.oil")
end)

later(function()
  add("tpope/vim-fugitive")
end)
