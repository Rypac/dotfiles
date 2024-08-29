local sessions = require("mini.sessions")
sessions.setup()

vim.keymap.set("n", "<Leader>O", sessions.select, { desc = "Load session" })
