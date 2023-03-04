import sublime
import sublime_plugin


class OpenSelectionCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit, new_window: bool = False):
        window = self.view.window()
        if new_window:
            sublime.run_command("new_window")
            window = sublime.active_window()

        syntax = syntax.path if (syntax := self.view.syntax()) is not None else ""
        new_view = window.new_file(syntax=syntax)
        new_view.set_scratch(True)

        for region in self.view.sel():
            selection_text = self.view.substr(region)
            new_view.insert(edit, 0, selection_text)

    def is_visible(self) -> bool:
        return any(not region.empty() for region in self.view.sel())
