from __future__ import annotations

import sys

import sublime
import sublime_plugin


class OpenInNewWindowCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit):
        sublime.run_command("new_window")
        new_window = sublime.active_window()

        new_window.run_command("open_file", {"file": self.view.file_name()})
        new_window.set_sidebar_visible(False)

    def is_visible(self) -> bool:
        return (name := self.view.file_name()) is not None and len(name) > 0


class OpenInFocusModeCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit):
        sublime.run_command("new_window")
        new_window = sublime.active_window()

        new_window.run_command("open_file", {"file": self.view.file_name()})
        new_window.run_command("toggle_focus_mode")

    def is_visible(self) -> bool:
        return (name := self.view.file_name()) is not None and len(name) > 0


class ToggleScratchCommand(sublime_plugin.TextCommand):
    def run(self, edit: sublime.Edit):
        self.view.set_scratch(not self.view.is_scratch())


class SplitToNextGroupCommand(sublime_plugin.WindowCommand):
    def clone_view(self, view: sublime.View):
        group, index = self.window.get_view_index(view)
        self.window.run_command("clone_file")

        if (new_view := self.window.active_view()) is None:
            return

        self.window.set_view_index(new_view, group, index)

        new_selections = new_view.sel()
        new_selections.clear()
        for selection in view.sel():
            new_selections.add(selection)

        new_view.set_viewport_position(view.viewport_position(), False)

    def run(self, move: bool = False):
        if not move and (view := self.window.active_view()):
            self.clone_view(view)

        if (group := self.window.active_group()) < self.window.num_groups() - 1:
            self.window.run_command("move_to_group", {"group": group + 1})
        else:
            self.window.run_command("new_pane", {"move": True})

    def is_visible(self) -> bool:
        group = self.window.active_group()
        sheets = self.window.sheets_in_group(group)
        return len(sheets) > 0


class CloseViewOrPaneCommand(sublime_plugin.WindowCommand):
    def run(self):
        active_group = self.window.active_group()
        if self.window.num_views_in_group(active_group) > 0:
            self.window.run_command("close")
        elif "Origami.origami" in sys.modules:
            self.window.run_command("destroy_pane", {"direction": "self"})
        else:
            self.window.run_command("close_pane")


class CloseGroupCommand(sublime_plugin.WindowCommand):
    def run(self):
        active_group = self.window.active_group()
        for view in self.window.views_in_group(active_group):
            if not view.is_dirty():
                view.close()

        if "Origami.origami" in sys.modules:
            self.window.run_command("destroy_pane", {"direction": "self"})
        else:
            self.window.run_command("close_pane")

    def is_visible(self) -> bool:
        return self.window.num_groups() > 1
