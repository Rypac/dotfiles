import sublime
import sublime_plugin


class OpenAndFocusSideBarCommand(sublime_plugin.WindowCommand):
    def run(self):
        self.window.set_sidebar_visible(True)
        sublime.set_timeout(lambda: self.window.run_command("focus_side_bar"), 100)


class CopyFilePathCommand(sublime_plugin.WindowCommand):
    def run(self, files):
        sublime.set_clipboard(files[0])
        self.window.status_message("Copied file path")

    def is_visible(self, files):
        return len(files) == 1


class CopyFolderPathCommand(sublime_plugin.WindowCommand):
    def run(self, dirs):
        sublime.set_clipboard(dirs[0])
        self.window.status_message("Copied folder path")

    def is_visible(self, dirs):
        return len(dirs) == 1


class OpenFileInNewWindowCommand(sublime_plugin.WindowCommand):
    def run(self, files):
        sublime.run_command("new_window")
        new_window = sublime.active_window()

        for file in files:
            new_window.run_command("open_file", {"file": file})

        new_window.set_tabs_visible(True)
        new_window.set_sidebar_visible(False)

    def is_visible(self, files):
        return len(files) > 0


class OpenFileInFocusModeCommand(sublime_plugin.WindowCommand):
    def run(self, files):
        sublime.run_command("new_window")
        new_window = sublime.active_window()

        new_window.run_command("open_file", {"file": files[0]})
        new_window.run_command("enter_focus_mode")

    def is_visible(self, files):
        return len(files) == 1
