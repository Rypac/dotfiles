return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { "init.lua", ".git" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        workspaceDelay = -1,
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath("data") .. "/site/pack/deps",
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
