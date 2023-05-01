return {
  "mg979/vim-visual-multi",
  event = "VeryLazy",
  version = false,
  keys = {
    { "<M-j>", ":call vm#commands#add_cursor_down(0, v:count1)<cr>" },
    { "<M-k>", ":call vm#commands#add_cursor_up(0, v:count1)<cr>" },
    { "<M-Down>", ":call vm#commands#add_cursor_down(0, v:count1)<cr>" },
    { "<M-Up>", ":call vm#commands#add_cursor_up(0, v:count1)<cr>" },
    { "<C-LeftMouse>", "<Plug>(VM-Mouse-Cursor)" },
    { "<C-RightMouse>", "<Plug>(VM-Mouse-Word)" },
    { "<M-C-RightMouse>", "<Plug>(VM-Mouse-Column)" },
  },
  config = function()
    vim.g.VM_theme = "nord"
  end,
}