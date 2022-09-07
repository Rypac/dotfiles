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
