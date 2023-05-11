import sublime
import sublime_plugin

import os


class GotoBookmarkInputHandler(sublime_plugin.ListInputHandler):
    def __init__(self, window: sublime.Window):
        self.window = window

    def name(self):
        return "bookmark"

    def placeholder(self):
        return "Choose a bookmark"

    def list_items(self):
        items = []
        for view in self.window.views():
            view_name = (
                name if (name := view.name()) else os.path.basename(view.file_name())
            )

            for region in view.get_regions("bookmarks"):
                row, column = view.rowcol(region.a)
                line = view.substr(view.line(region)).strip()
                items.append(
                    sublime.ListInputItem(
                        text=view_name,
                        value={"view_id": view.id(), "region": region.to_tuple()},
                        details=f"<code>{line}</code>",
                        annotation=f"{row + 1}:{column + 1}",
                    )
                )

        return items or ["No bookmarks"]


class GotoBookmarkCommand(sublime_plugin.WindowCommand):
    def input_description(self):
        return "View Bookmark"

    def input(self, args):
        if args.get("bookmark") is None:
            return GotoBookmarkInputHandler(self.window)
        return None

    def run(self, bookmark=None):
        if not bookmark:
            return

        view_id = bookmark["view_id"]
        view = next(
            (view for view in self.window.views() if view.id() == view_id),
            None,
        )
        if not view:
            return

        a, b = bookmark["region"]
        region = sublime.Region(a, b)
        self.window.focus_view(view)
        view.show_at_center(region)
        view.sel().clear()
        view.sel().add(region)
