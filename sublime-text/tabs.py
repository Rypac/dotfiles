import os

import sublime
import sublime_plugin


class TabContextCommand(sublime_plugin.WindowCommand):
    def sheet(self, group, index):
        if group < 0 or index < 0:
            return None

        sheets = self.window.sheets_in_group(int(group))
        return sheets[index] if -1 < index < len(sheets) else None

    def view(self, group, index):
        sheet = self.sheet(group, index)
        return sheet.view() if sheet is not None else None

    def file_name(self, group, index):
        view = self.view(group, index)
        return view.file_name() if view is not None else None


class RevealTabInFinderCommand(TabContextCommand):
    def run(self, group=-1, index=-1):
        file_name = self.file_name(group, index)

        if file_name is not None:
            path, name = os.path.split(file_name)
            self.window.run_command("open_dir", {"dir": path, "file": name})


class CopyTabFilePathCommand(TabContextCommand):
    def run(self, group=-1, index=-1):
        file_name = self.file_name(group, index)

        if file_name is not None:
            sublime.set_clipboard(file_name)
            sublime.status_message("Copied file path")


class RevealTabInSideBarCommand(TabContextCommand):
    def run(self, group=-1, index=-1):
        view = self.view(group, index)

        if view is not None:
            self.window.focus_view(view)
            self.window.run_command('reveal_in_side_bar')


class OpenTabInNewWindowCommand(TabContextCommand):
    def run(self, group=-1, index=-1):
        file_name = self.file_name(group, index)

        if file_name is not None:
            sublime.run_command("new_window")
            new_window = sublime.active_window()

            new_window.run_command("open_file", {"file": file_name})

            new_window.set_tabs_visible(True)
            new_window.set_sidebar_visible(False)
