import sublime
import sublime_plugin


class EnableViewScratchCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit) -> None:
        self.view.set_scratch(True)

    def is_visible(self) -> bool:
        return not self.view.is_scratch()


class DisableViewScratchCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit) -> None:
        self.view.set_scratch(False)

    def is_visible(self) -> bool:
        return self.view.is_scratch()
