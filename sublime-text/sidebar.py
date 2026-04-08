from typing import override

import sublime
from sublime_plugin import ApplicationCommand, WindowCommand


class OpenAndFocusSideBarCommand(WindowCommand):
    @override
    def run(self):
        self.window.set_sidebar_visible(True)
        sublime.set_timeout(lambda: self.window.run_command("focus_side_bar"), 100)


class OpenFileInNewWindowCommand(ApplicationCommand):
    @override
    def run(self, files: list[str]):
        sublime.run_command("new_window")
        new_window = sublime.active_window()

        for file in files:
            new_window.run_command("open_file", {"file": file})

        new_window.set_sidebar_visible(False)

    @override
    def is_visible(self, files: list[str]) -> bool:
        return len(files) > 0


class OpenFolderInNewWindowCommand(ApplicationCommand):
    @override
    def run(self, dirs: list[str]):
        sublime.run_command("new_window")
        new_window = sublime.active_window()

        project = new_window.project_data() or {}
        folders = project.setdefault("folders", [])

        for dir in dirs:
            folders.append({"path": dir})

        new_window.set_project_data(project)

    @override
    def is_visible(self, dirs: list[str]) -> bool:
        return len(dirs) > 0


class OpenFileInFocusModeCommand(ApplicationCommand):
    @override
    def run(self, files: list[str]):
        sublime.run_command("new_window")
        new_window = sublime.active_window()

        new_window.run_command("open_file", {"file": files[0]})
        new_window.run_command("toggle_focus_mode")

    @override
    def is_visible(self, files: list[str]) -> bool:
        return len(files) == 1


class LaunchFileCommand(ApplicationCommand):
    @override
    def run(self, files: list[str]):
        import os
        import subprocess

        try:
            match sublime.platform():
                case "windows":
                    os.startfile(files[0])
                case "osx":
                    subprocess.run(["/usr/bin/open", *files], check=True)
                case "linux":
                    subprocess.run(["/usr/bin/xdg-open", files[0]], check=True)
                case _:
                    pass
        except Exception as e:
            sublime.error_message(str(e))

    @override
    def is_visible(self, files: list[str]) -> bool:
        return len(files) > 0

    @override
    def is_enabled(self, files: list[str]) -> bool:
        return sublime.platform() == "osx" or len(files) == 1
