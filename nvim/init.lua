pcall(function()
  vim.loader.enable()
end)

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
  dofile(vim.fn.stdpath("config") .. "/lua/" .. path)
end

now(function()
  source("config/globals.lua")
  source("config/options.lua")
  source("config/autocmds.lua")
  source("config/commands.lua")
  source("config/keymaps.lua")
end)

now(function()
  add("sainnhe/gruvbox-material")
  add("echasnovski/mini.colors")
  source("plugins/gruvbox-material.lua")
end)

now(function()
  add("sainnhe/everforest")
  add("echasnovski/mini.colors")
end)

now(function()
  add("echasnovski/mini.sessions")
  source("plugins/mini-sessions.lua")
end)

now(function()
  add("echasnovski/mini.statusline")
  source("plugins/mini-statusline.lua")
end)

now(function()
  add("tpope/vim-fugitive")
end)

later(function()
  add("echasnovski/mini.extra")
  source("plugins/mini-extra.lua")
end)

later(function()
  add("echasnovski/mini.ai")
  source("plugins/mini-ai.lua")
end)

later(function()
  add("echasnovski/mini.move")
  source("plugins/mini-move.lua")
end)

later(function()
  add("echasnovski/mini.pairs")
  source("plugins/mini-pairs.lua")
end)

later(function()
  add("echasnovski/mini.pick")
  source("plugins/mini-pick.lua")
end)

later(function()
  add("echasnovski/mini.splitjoin")
  source("plugins/mini-splitjoin.lua")
end)

later(function()
  add("echasnovski/mini.surround")
  source("plugins/mini-surround.lua")
end)

later(function()
  add("echasnovski/mini.visits")
  source("plugins/mini-visits.lua")
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
  source("plugins/treesitter.lua")
end)

local oil = function()
  add("stevearc/oil.nvim")
  source("plugins/oil.lua")
end

if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) then
  now(oil)
else
  later(oil)
end
