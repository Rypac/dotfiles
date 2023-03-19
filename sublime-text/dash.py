import sublime
import sublime_plugin

import subprocess
from urllib.parse import quote


class DashCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit):
        selection = self.view.sel()[0]
        if len(selection) == 0:
            selection = self.view.word(selection)
        query = self.view.substr(selection)

        scope_names = self.view.scope_name(selection.a).split(' ')
        source = next(name.split('.')[1] for name in scope_names if name.startswith('source.'))

        if source:
            subprocess.call([
                '/usr/bin/open', '-g',
                f"dash-plugin://keys={source}&query={quote(query)}"
            ])
        else:
            subprocess.call([
                '/usr/bin/open', '-g',
                f"dash-plugin://query={quote(query)}"
            ])
