local statusline = require("mini.statusline")
statusline.setup({ use_icons = false })

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Update bookmarked state for statusline",
  group = vim.api.nvim_create_augroup("UserBookmarkState", { clear = true }),
  callback = function(args)
    local ok, visits = pcall(require, "mini.visits")
    vim.b[args.buf].bookmark = ok
      and args.file ~= ""
      and #visits.list_labels(args.file, vim.uv.cwd(), { filter = "bookmark" }) > 0
  end,
})

statusline.section_location = function()
  local line_number = "%2l|%L"
  return vim.b.bookmark == true and line_number .. " •" or line_number
end

vim.o.showmode = false
