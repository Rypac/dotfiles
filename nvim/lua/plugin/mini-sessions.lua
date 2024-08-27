local sessions = require("mini.sessions")
sessions.setup()

vim.keymap.set("n", "<Leader>s", sessions.select, { desc = "Load session" })
