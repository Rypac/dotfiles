import sublime
import sublime_plugin


class ToggleViewScratchCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit) -> None:
        self.view.set_scratch(not self.view.is_scratch())
