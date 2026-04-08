from typing import override

from sublime_plugin import WindowCommand


class SaveAllExistingCommand(WindowCommand):
    @override
    def run(self):
        for view in self.window.views():
            if view.file_name():
                view.run_command("save", {"async": True})
