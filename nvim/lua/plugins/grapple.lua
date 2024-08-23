require("grapple").setup({
  icons = false,
  style = "basename",
  scope = "session",
  scopes = {
    {
      name = "session",
      desc = "Persisted session",
      fallback = "git",
      cache = {
        event = { "DirChanged", "SessionLoadPost", "SessionWritePost" },
      },
      resolver = function()
        local session = vim.v.this_session
        if session == "" then
          return
        end

        return session, vim.uv.cwd()
      end,
    },
  },
})

vim.keymap.set("n", "+", "<Cmd>Grapple toggle<CR>", { desc = "Toggle a Grapple tag" })
vim.keymap.set("n", "_", "<Cmd>Grapple toggle_tags<CR>", { desc = "Toggle Grapple tags window" })

vim.api.nvim_create_autocmd("User", {
  desc = "Redraw statusline on Grapple update",
  pattern = "GrappleUpdate",
  group = vim.api.nvim_create_augroup("UserGrappleRedrawStatusline", { clear = true }),
  command = "redrawstatus",
})
