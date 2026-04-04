from typing import override

import sublime
import sublime_plugin


class FontSizeInputHandler(sublime_plugin.TextInputHandler):
    def __init__(self, current_size: int):
        self._current_size = current_size

    @override
    def placeholder(self) -> str:
        return "Font Size"

    @override
    def initial_text(self) -> str:
        return str(size) if (size := self._current_size) is not None else ""

    @override
    def validate(self, size: str) -> bool:
        try:
            return 8 <= int(size) <= 128
        except ValueError:
            return False


class SetViewFontSizeCommand(sublime_plugin.TextCommand):
    @override
    def run(self, edit: sublime.Edit, font_size: str | None = None):
        if font_size is not None:
            self.view.settings().set("font_size", int(font_size))

    @override
    def input(self, args) -> sublime_plugin.CommandInputHandler | None:
        return (
            FontSizeInputHandler(current_size=self.view.settings().get("font_size"))
            if args.get("font_size") is None
            else None
        )


class IncreaseViewFontSize(sublime_plugin.TextCommand):
    @override
    def run(self, edit: sublime.Edit):
        font_size = self.view.settings().get("font_size", 10)

        if font_size >= 36:
            font_size += 4
        elif font_size >= 24:
            font_size += 2
        else:
            font_size += 1

        self.view.settings().set("font_size", min(128, font_size))


class DecreaseViewFontSize(sublime_plugin.TextCommand):
    @override
    def run(self, edit: sublime.Edit):
        font_size = self.view.settings().get("font_size", 10)

        if font_size >= 40:
            font_size -= 4
        elif font_size >= 26:
            font_size -= 2
        else:
            font_size -= 1

        self.view.settings().set("font_size", max(8, font_size))


class ResetViewFontSizeCommand(sublime_plugin.TextCommand):
    @override
    def run(self, edit: sublime.Edit):
        self.view.settings().erase("font_size")
