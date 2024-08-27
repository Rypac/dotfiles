return function()
  return {
    name = "swift-language-server",
    cmd = { "xcrun", "sourcekit-lsp" },
    root_dir = vim.fs.root(0, "Package.swift"),
  }
end
