vim.loader.enable()

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

later(function()
  source("config/lsp.lua")
  source("config/diagnostics.lua")
end)

now(function()
  vim.cmd("ApplyColorscheme iceberg")
end)

now(function()
  add("tpope/vim-fugitive")
  source("plugin/fugitive.lua")
end)

now(function()
  source("plugin/mini-files.lua")
  source("plugin/mini-sessions.lua")
  source("plugin/mini-starter.lua")
  source("plugin/mini-statusline.lua")
end)

later(function()
  source("plugin/mini-extra.lua")
  source("plugin/mini-ai.lua")
  source("plugin/mini-clue.lua")
  source("plugin/mini-diff.lua")
  source("plugin/mini-misc.lua")
  source("plugin/mini-move.lua")
  source("plugin/mini-pick.lua")
  source("plugin/mini-splitjoin.lua")
  source("plugin/mini-surround.lua")
  source("plugin/mini-visits.lua")
end)

now(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "main",
    hooks = {
      post_checkout = function()
        vim.cmd("TSUpdate")
      end,
    },
  })
  add({
    source = "nvim-treesitter/nvim-treesitter-textobjects",
    checkout = "main",
  })
  source("plugin/nvim-treesitter.lua")
  source("plugin/nvim-treesitter-textobjects.lua")
end)
