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
    def run(self, group: int = -1, index: int = -1):
        import os

        if path := self.file_name(group, index):
            dir, file = os.path.split(path)
            self.window.run_command("open_dir", {"dir": dir, "file": file})

    def is_visible(self, group: int = -1, index: int = -1) -> bool:
        return (name := self.file_name(group, index)) is not None and len(name) > 0


class CopyTabFilePathCommand(TabContextCommand):
    def run(self, group: int = -1, index: int = -1):
        if path := self.file_name(group, index):
            sublime.set_clipboard(path)
            self.window.status_message("Copied file path")

    def is_visible(self, group: int = -1, index: int = -1) -> bool:
        return (name := self.file_name(group, index)) is not None and len(name) > 0


class RevealTabInSideBarCommand(TabContextCommand):
    def run(self, group: int = -1, index: int = -1):
        if view := self.view(group, index):
            self.window.focus_view(view)
            self.window.run_command("reveal_in_side_bar")

    def is_visible(self, group: int = -1, index: int = -1) -> bool:
        return (name := self.file_name(group, index)) is not None and len(name) > 0


class OpenTabInNewWindowCommand(TabContextCommand):
    def run(self, group: int = -1, index: int = -1):
        if path := self.file_name(group, index):
            sublime.run_command("new_window")
            new_window = sublime.active_window()

            new_window.run_command("open_file", {"file": path})
            new_window.set_sidebar_visible(False)


class OpenTabInFocusModeCommand(TabContextCommand):
    def run(self, group: int = -1, index: int = -1):
        if path := self.file_name(group, index):
            sublime.run_command("new_window")
            new_window = sublime.active_window()

            new_window.run_command("open_file", {"file": path})
            new_window.run_command("focus_mode", {"enable": True})


class SplitTabToNextGroupCommand(TabContextCommand):
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

    def run(self, group: int = -1, index: int = -1, move: bool = False):
        if view := self.view(group, index):
            self.window.focus_view(view)

            if not move:
                self.clone_view(view)

            if (group := self.window.active_group()) < self.window.num_groups() - 1:
                self.window.run_command("move_to_group", {"group": group + 1})
            else:
                self.window.run_command("new_pane", {"move": True})
