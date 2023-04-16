from __future__ import annotations

import sublime
import sublime_plugin


class FontSizeInputHandler(sublime_plugin.TextInputHandler):
    def __init__(self, current_size: int):
        self._current_size = current_size

    def placeholder(self) -> str:
        return "Font Size"

    def initial_text(self) -> str:
        return str(size) if (size := self._current_size) is not None else ""

    def validate(self, size: str) -> bool:
        try:
            return 8 <= int(size) <= 128
        except ValueError:
            return False


class SetViewFontSizeCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit, font_size: str | None = None):
        if font_size is not None:
            self.view.settings().set("font_size", int(font_size))

    def input(self, args) -> sublime_plugin.CommandInputHandler | None:
        return (
            FontSizeInputHandler(current_size=self.view.settings().get("font_size"))
            if args.get("font_size") is None
            else None
        )


class ResetViewFontSizeCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit):
        self.view.settings().erase("font_size")
