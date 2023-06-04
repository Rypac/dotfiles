from __future__ import annotations

import sublime
import sublime_plugin
import subprocess


class OpenInBrowser(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit):
        if filename := self.view.file_name():
            subprocess.run(["open", "-a", "Safari.app", filename], check=True)
