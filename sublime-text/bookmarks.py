import os
from typing import override

from sublime import ListInputItem, Region, Window
from sublime_plugin import CommandInputHandler, ListInputHandler, WindowCommand


class GotoBookmarkInputHandler(ListInputHandler):
    def __init__(self, window: Window):
        self.window = window

    @override
    def name(self) -> str:
        return "bookmark"

    @override
    def placeholder(self) -> str:
        return "Choose a bookmark"

    @override
    def list_items(self) -> list[str] | list[ListInputItem]:
        items = []
        for view in self.window.views():
            name = view.name() or os.path.basename(view.file_name())

            for region in view.get_regions("bookmarks"):
                row, column = view.rowcol(region.a)
                line = view.substr(view.line(region)).strip()
                items.append(
                    ListInputItem(
                        text=name,
                        value={"view_id": view.id(), "region": region.to_tuple()},
                        details=f"<code>{line}</code>",
                        annotation=f"{row + 1}:{column + 1}",
                    )
                )

        return items or ["No bookmarks"]

    @override
    def validate(self, text: str) -> bool:
        return text != "No bookmarks"


class GotoBookmarkCommand(WindowCommand):
    @override
    def input_description(self) -> str:
        return "View Bookmark"

    @override
    def input(self, args: dict) -> CommandInputHandler | None:
        return (
            GotoBookmarkInputHandler(self.window)
            if args.get("bookmark") is None
            else None
        )

    @override
    def run(self, bookmark: dict | None = None):
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
        region = Region(a, b)
        self.window.focus_view(view)
        view.show_at_center(region)
        view.sel().clear()
        view.sel().add(region)
