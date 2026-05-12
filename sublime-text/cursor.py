from sublime import Edit
from sublime_plugin import TextCommand


class AlignCursors(TextCommand):
    def run(self, edit: Edit) -> None:
        max_point = 0
        for cursor in self.view.sel():
            _, point = self.view.rowcol(cursor.b)
            if max_point < point:
                max_point = point

        for cursor in reversed(self.view.sel()):
            _, point = self.view.rowcol(cursor.b)
            if point < max_point:
                self.view.insert(edit, cursor.b, " " * (max_point - point))
