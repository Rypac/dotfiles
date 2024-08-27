pcall(function()
  vim.loader.enable()
end)

local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/Rypac/mini.nvim",
    mini_path,
  })
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

local deps = require("mini.deps")
deps.setup({
  path = {
    package = path_package,
  },
})

local add, now, later = deps.add, deps.now, deps.later

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
  source("plugin/gruvbox-material.lua")
end)

now(function()
  add("sainnhe/everforest")
end)

now(function()
  source("plugin/mini-files.lua")
end)

now(function()
  source("plugin/mini-sessions.lua")
end)

now(function()
  source("plugin/mini-statusline.lua")
end)

now(function()
  add("tpope/vim-fugitive")
end)

later(function()
  source("plugin/mini-extra.lua")
end)

later(function()
  source("plugin/mini-ai.lua")
end)

later(function()
  source("plugin/mini-misc.lua")
end)

later(function()
  source("plugin/mini-move.lua")
end)

later(function()
  source("plugin/mini-pairs.lua")
end)

later(function()
  source("plugin/mini-pick.lua")
end)

later(function()
  source("plugin/mini-splitjoin.lua")
end)

later(function()
  source("plugin/mini-surround.lua")
end)

later(function()
  source("plugin/mini-visits.lua")
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
  source("plugin/treesitter.lua")
end)
