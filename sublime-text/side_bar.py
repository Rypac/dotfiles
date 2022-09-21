from __future__ import annotations

import sublime
import sublime_plugin


class OpenAndFocusSideBarCommand(sublime_plugin.WindowCommand):
    def run(self):
        self.window.set_sidebar_visible(True)
        sublime.set_timeout(lambda: self.window.run_command("focus_side_bar"), 100)


class CopyFilePathCommand(sublime_plugin.WindowCommand):
    def run(self, files: list[str]):
        sublime.set_clipboard(files[0])
        self.window.status_message("Copied file path")

    def is_visible(self, files: list[str]) -> bool:
        return len(files) == 1 and len(files[0]) > 0


class CopyFolderPathCommand(sublime_plugin.WindowCommand):
    def run(self, dirs: list[str]):
        sublime.set_clipboard(dirs[0])
        self.window.status_message("Copied folder path")

    def is_visible(self, dirs: list[str]) -> bool:
        return len(dirs) == 1 and len(dirs[0]) > 0


class OpenFileInNewWindowCommand(sublime_plugin.WindowCommand):
    def run(self, files: list[str]):
        sublime.run_command("new_window")
        new_window = sublime.active_window()

        for file in files:
            new_window.run_command("open_file", {"file": file})

        new_window.set_sidebar_visible(False)

    def is_visible(self, files: list[str]) -> bool:
        return len(files) > 0


class OpenFolderInNewWindowCommand(sublime_plugin.WindowCommand):
    def run(self, dirs: list[str]):
        import os
        import subprocess

        executable_path = sublime.executable_path()

        if sublime.platform() == "osx":
            app_path = executable_path[: executable_path.rfind(".app/") + 5]
            executable_path = os.path.join(app_path, "Contents/SharedSupport/bin/subl")

        try:
            subprocess.Popen([executable_path, "--new-window"] + dirs)
        except Exception as e:
            sublime.error_message(str(e))

    def is_visible(self, dirs: list[str]) -> bool:
        return len(dirs) > 0


class OpenFileInFocusModeCommand(sublime_plugin.WindowCommand):
    def run(self, files: list[str]):
        sublime.run_command("new_window")
        new_window = sublime.active_window()

        new_window.run_command("open_file", {"file": files[0]})
        new_window.run_command("enter_focus_mode")

    def is_visible(self, files: list[str]) -> bool:
        return len(files) == 1


class LaunchFileCommand(sublime_plugin.WindowCommand):
    def run(self, files: list[str]):
        import os
        import subprocess

        try:
            if sublime.platform() == "windows":
                os.startfile(files[0])
            elif sublime.platform() == "osx":
                subprocess.check_call(["open", *files])
            else:
                subprocess.check_call(["xdg-open", files[0]])
        except Exception as e:
            sublime.error_message(str(e))

    def is_visible(self, files: list[str]) -> bool:
        return len(files) > 0

    def is_enabled(self, files: list[str]) -> bool:
        return sublime.platform() == "osx" or len(files) == 1
