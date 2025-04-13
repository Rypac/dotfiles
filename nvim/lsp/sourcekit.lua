return {
  cmd = { "xcrun", "sourcekit-lsp" },
  filetypes = { "swift" },
  root_markers = { "Package.swift", ".git" },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
    textDocument = {
      diagnostic = {
        dynamicRegistration = true,
        relatedDocumentSupport = true,
      },
    },
  },
}
