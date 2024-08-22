local grapple = require("grapple")
grapple.setup({
  icons = false,
  style = "basename",
})

vim.keymap.set("n", ",", function()
  grapple.toggle()
end, {
  desc = "Toggle a Grapple tag",
})

vim.keymap.set("n", "<Leader>,", function()
  grapple.toggle_tags()
end, {
  desc = "Toggle Grapple tags window",
})

for index = 1, 9 do
  vim.keymap.set("n", "<Leader>" .. index, function()
    grapple.select({ index = index })
  end, {
    desc = "Select Grapple tag " .. index,
  })
end

vim.keymap.set("n", "+", function()
  vim.ui.input({ prompt = "Add a Grapple tag: " }, function(name)
    if name ~= nil then
      grapple.tag({ name = name })
    end
  end)
end, {
  desc = "Add a named Grapple tag",
})

vim.api.nvim_create_autocmd("User", {
  desc = "Redraw statusline on Grapple update",
  pattern = "GrappleUpdate",
  group = vim.api.nvim_create_augroup("UserGrappleRedrawStatusline", { clear = true }),
  command = "redrawstatus",
})
