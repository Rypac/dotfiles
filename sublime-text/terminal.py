from __future__ import annotations

import os
import subprocess

import sublime
import sublime_plugin


class OpenTerminalCommand(sublime_plugin.WindowCommand):
    def run(self, paths=[], in_folder=False):
        path = None

        if paths:
            path = paths[0]
        elif (
            not in_folder
            and (view := self.window.active_view())
            and (file_name := view.file_name())
        ):
            path = file_name
        elif folders := self.window.folders():
            path = folders[0]
        else:
            path = os.path.expanduser("~")

        if os.path.isfile(path):
            path = os.path.dirname(path)

        try:
            subprocess.run(
                [
                    "osascript",
                    "-e",
                    f'do shell script "open -a \'Terminal\' \\"{path}\\""',
                ],
                check=True,
            )
        except Exception as e:
            sublime.error_message("Terminal: " + str(e))

    def is_visible(self, paths=[], in_folder=False) -> bool:
        if sublime.platform() != "osx":
            return False

        if in_folder:
            return bool(self.window.folders())

        return bool(paths or ((view := self.window.active_view()) and view.file_name()))
