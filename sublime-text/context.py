import sublime
import sublime_plugin


class OpenViewInNewWindowCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        file_name = self.view.file_name()

        sublime.run_command("new_window")
        new_window = sublime.active_window()

        new_window.run_command("open_file", {"file": file_name})

        new_window.set_tabs_visible(True)
        new_window.set_sidebar_visible(False)

    def is_visible(self):
        return self.view.file_name() is not None


class OpenViewInFocusModeCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        file_name = self.view.file_name()

        sublime.run_command("new_window")
        new_window = sublime.active_window()

        new_window.run_command("open_file", {"file": file_name})
        new_window.run_command("enter_focus_mode")

    def is_visible(self):
        return self.view.file_name() is not None


class SplitToNextGroupCommand(sublime_plugin.WindowCommand):
    def clone_view(self, view):
        if view is None:
            return

        group, index = self.window.get_view_index(view)
        self.window.run_command("clone_file")

        if (new_view := self.window.active_view()) is None:
            return

        self.window.set_view_index(new_view, group, index)

        new_selections = new_view.sel()
        new_selections.clear()
        for selection in view.sel():
            new_selections.add(selection)

        sublime.set_timeout(lambda: new_view.set_viewport_position(view.viewport_position(), False))

    def run(self, move=False):
        if not move:
            self.clone_view(self.window.active_view())

        if (group := self.window.active_group()) < self.window.num_groups() - 1:
            self.window.run_command("move_to_group", {"group": group + 1})
        else:
            self.window.run_command("new_pane", {"move": True})

    def is_visible(self):
        group = self.window.active_group()
        sheets = self.window.sheets_in_group(group)
        return len(sheets) > 0


class CloseGroupCommand(sublime_plugin.WindowCommand):
    def run(self):
        self.window.run_command("close_pane")

    def is_visible(self):
        return self.window.num_groups() > 1
