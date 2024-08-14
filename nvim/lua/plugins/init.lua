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

local source = function(path)
  dofile(vim.fn.stdpath("config") .. "/lua/" .. path .. ".lua")
end

now(function()
  add("echasnovski/mini.statusline")
  source("plugins/mini_statusline")
end)

now(function()
  add("sainnhe/gruvbox-material")
  add("echasnovski/mini.colors")
  source("plugins/gruvbox_material")
end)

now(function()
  add("echasnovski/mini.sessions")
  source("plugins/mini_sessions")
end)

now(function()
  add("echasnovski/mini.starter")
  source("plugins/mini_starter")
end)

later(function()
  add("echasnovski/mini.extra")
  source("plugins/mini_extra")
end)

later(function()
  add("echasnovski/mini.ai")
  source("plugins/mini_ai")
end)

later(function()
  add("echasnovski/mini.jump2d")
  source("plugins/mini_jump2d")
end)

later(function()
  add("echasnovski/mini.pairs")
  source("plugins/mini_pairs")
end)

later(function()
  add("echasnovski/mini.pick")
  source("plugins/mini_pick")
end)

later(function()
  add("echasnovski/mini.splitjoin")
  source("plugins/mini_splitjoin")
end)

later(function()
  add("echasnovski/mini.surround")
  source("plugins/mini_surround")
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
  source("plugins/treesitter")
end)

later(function()
  add("stevearc/oil.nvim")
  source("plugins/oil")
end)

later(function()
  add("tpope/vim-fugitive")
end)
