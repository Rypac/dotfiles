import sublime
import sublime_plugin


class FontSizeInputHandler(sublime_plugin.TextInputHandler):
    def __init__(self, view: sublime.View):
        self.view = view

    def placeholder(self) -> str:
        return "Font Size"

    def initial_text(self) -> str:
        return str(self.view.settings().get("font_size"))

    def validate(self, size: str) -> bool:
        try:
            return 8 <= int(size) <= 128
        except ValueError:
            return False


class SetViewFontSizeCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit, font_size: str):
        self.view.settings().set("font_size", int(font_size))

    def input(self, args):
        return FontSizeInputHandler(self.view)


class ResetViewFontSizeCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit):
        self.view.settings().erase("font_size")
