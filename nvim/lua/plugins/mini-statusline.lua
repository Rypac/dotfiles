local statusline = require("mini.statusline")
statusline.setup({
  use_icons = false,
})

local function has_grapple_tag()
  if package.loaded["grapple"] == nil then
    return false
  end

  local ok, grapple = pcall(require, "grapple")
  return ok and grapple.exists()
end

statusline.section_location = function()
  local line_number = "%2l|%L"
  return has_grapple_tag() and line_number .. " •" or line_number
end

vim.opt.showmode = false
