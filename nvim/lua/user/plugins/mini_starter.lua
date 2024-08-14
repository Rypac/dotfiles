local section = function(name, items)
  return vim.tbl_map(function(item)
    return {
      name = item[1],
      action = item[2],
      section = name,
    }
  end, items)
end

local starter = require("mini.starter")
starter.setup({
  items = {
    section("Builtin actions", {
      { "Edit new buffer", "enew" },
      { "Search", "Pick grep_live" },
      { "Find files", "Pick files" },
      { "Browse files", "Oil" },
      { "Update plugins", "DepsUpdate" },
      { "Quit Neovim", "qall" },
    }),
    starter.sections.sessions(5),
    starter.sections.recent_files(5, false, false),
  },
  footer = "",
})

vim.keymap.set("n", "<Leader>~", "<Cmd>lua MiniStarter.open()<CR>", { desc = "Open start screen" })
