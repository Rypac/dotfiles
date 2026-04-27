from datetime import datetime
from typing import override

from sublime import Edit
from sublime_plugin import TextCommand


class InsertDateHeaderCommand(TextCommand):
    @override
    def run(self, edit: Edit):
        now = datetime.now()
        header = now.strftime("### %Y-%m-%d — %A, %d %B")
        for region in self.view.sel():
            self.view.insert(edit, region.begin(), header)
