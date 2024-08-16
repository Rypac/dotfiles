local statusline = require("mini.statusline")
statusline.setup({
  use_icons = false,
})

statusline.section_location = function()
  return "%2l|%L"
end

vim.opt.showmode = false
