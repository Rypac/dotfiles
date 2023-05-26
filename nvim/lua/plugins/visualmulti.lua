return {
  "mg979/vim-visual-multi",
  event = "VeryLazy",
  keys = {
    {
      "<C-j>",
      ":call vm#commands#add_cursor_down(0, v:count1)<cr>",
      desc = "Add cursor down",
    },
    {
      "<C-k>",
      ":call vm#commands#add_cursor_up(0, v:count1)<cr>",
      desc = "Add cursor up",
    },
    {
      "<C-LeftMouse>",
      "<Plug>(VM-Mouse-Cursor)",
    },
    {
      "<C-RightMouse>",
      "<Plug>(VM-Mouse-Word)",
    },
    {
      "<M-C-RightMouse>",
      "<Plug>(VM-Mouse-Column)",
    },
  },
}
