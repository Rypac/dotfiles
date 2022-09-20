from typing import Optional

import sublime
import sublime_plugin


class TabContextCommand(sublime_plugin.WindowCommand):
    def sheet(self, group: int, index: int) -> Optional[sublime.View]:
        if group < 0 or index < 0:
            return None

        sheets = self.window.sheets_in_group(int(group))
        return sheets[index] if -1 < index < len(sheets) else None

    def view(self, group: int, index: int) -> Optional[sublime.View]:
        return sheet.view() if (sheet := self.sheet(group, index)) else None

    def file_name(self, group: int, index: int) -> Optional[str]:
        return view.file_name() if (view := self.view(group, index)) else None


class RevealTabInFinderCommand(TabContextCommand):
    def run(self, group=-1, index=-1):
        import os

        if path := self.file_name(group, index):
            dir, file = os.path.split(path)
            self.window.run_command("open_dir", {"dir": dir, "file": file})

    def is_visible(self, group=-1, index=-1) -> bool:
        return self.file_name(group, index) is not None


class CopyTabFilePathCommand(TabContextCommand):
    def run(self, group=-1, index=-1):
        if path := self.file_name(group, index):
            sublime.set_clipboard(path)
            self.window.status_message("Copied file path")

    def is_visible(self, group=-1, index=-1) -> bool:
        return self.file_name(group, index) is not None


class RevealTabInSideBarCommand(TabContextCommand):
    def run(self, group=-1, index=-1):
        if view := self.view(group, index):
            self.window.focus_view(view)
            self.window.run_command("reveal_in_side_bar")

    def is_visible(self, group=-1, index=-1) -> bool:
        return self.file_name(group, index) is not None


class OpenTabInNewWindowCommand(TabContextCommand):
    def run(self, group=-1, index=-1):
        if path := self.file_name(group, index):
            sublime.run_command("new_window")
            new_window = sublime.active_window()

            new_window.run_command("open_file", {"file": path})

            new_window.set_tabs_visible(True)
            new_window.set_sidebar_visible(False)


class OpenTabInFocusModeCommand(TabContextCommand):
    def run(self, group=-1, index=-1):
        if path := self.file_name(group, index):
            sublime.run_command("new_window")
            new_window = sublime.active_window()

            new_window.run_command("open_file", {"file": path})
            new_window.run_command("enter_focus_mode")
