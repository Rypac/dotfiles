require("mini.deps").add({
  source = "nvim-treesitter/nvim-treesitter",
  checkout = "main",
  hooks = {
    post_checkout = function()
      vim.cmd("TSUpdate")
    end,
  },
})

require("nvim-treesitter").install({
  "bash",
  "c",
  "comment",
  "css",
  "diff",
  "dockerfile",
  "editorconfig",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitignore",
  "go",
  "haskell",
  "html",
  "java",
  "javascript",
  "json",
  "kotlin",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "objc",
  "proto",
  "python",
  "query",
  "rust",
  "sql",
  "swift", -- Requires node to be installed
  "toml",
  "vim",
  "vimdoc",
  "yaml",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
