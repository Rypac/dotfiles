from __future__ import annotations

import sublime
import sublime_plugin


class OpenSelectionCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit, new_window: bool = False):
        if new_window:
            sublime.run_command("new_window")
            window = sublime.active_window()
        elif (window := self.view.window()) is None:
            return

        syntax = syntax.path if (syntax := self.view.syntax()) is not None else ""
        new_view = window.new_file(syntax=syntax)
        new_view.settings().update(self.view.settings().to_dict())
        new_view.set_scratch(True)

        for region in self.view.sel():
            selection_text = self.view.substr(region)
            new_view.run_command("append", {"characters": selection_text})

    def is_visible(self) -> bool:
        return any(not region.empty() for region in self.view.sel())


class ClearSelectionCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit):
        selection = self.view.sel()
        carets = [region.b for region in selection]

        selection.clear()
        for caret in carets:
            selection.add(caret)

    def is_visible(self) -> bool:
        return any(not region.empty() for region in self.view.sel())
