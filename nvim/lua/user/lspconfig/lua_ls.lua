return function()
  return {
    name = "lua-language-server",
    cmd = { "lua-language-server" },
    root_dir = vim.fs.root(0, { ".git", "init.lua" }),
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            vim.fn.stdpath("data") .. "/site/pack/deps",
          },
        },
      },
    },
  }
end
