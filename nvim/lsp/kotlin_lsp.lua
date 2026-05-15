return {
  filetypes = { "kotlin" },
  cmd = { "intellij-server", "--stdio" },
  root_markers = {
    "settings.gradle",
    "settings.gradle.kts",
    "pom.xml",
    "build.gradle",
    "build.gradle.kts",
    "workspace.json",
  },
}
