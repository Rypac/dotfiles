require("grapple").setup({
  icons = false,
  style = "basename",
})

vim.keymap.set("n", "+", "<Cmd>Grapple toggle<CR>", { desc = "Toggle a Grapple tag" })
vim.keymap.set("n", "_", "<Cmd>Grapple toggle_tags<CR>", { desc = "Toggle Grapple tags window" })

vim.api.nvim_create_autocmd("User", {
  desc = "Redraw statusline on Grapple update",
  pattern = "GrappleUpdate",
  group = vim.api.nvim_create_augroup("UserGrappleRedrawStatusline", { clear = true }),
  command = "redrawstatus",
})
