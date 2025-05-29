from __future__ import annotations

import sublime_plugin


class SaveAllExistingCommand(sublime_plugin.WindowCommand):
    def run(self):
        for view in self.window.views():
            if view.file_name():
                view.run_command("save", {"async": True})
