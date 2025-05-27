from __future__ import annotations

import os
from pathlib import Path

import sublime
import sublime_plugin
from Default.history_list import jump_history_dict


def recent_window_history() -> list[sublime.Window]:
    active_window = sublime.active_window()

    inactive_windows = {
        window.id(): window
        for window in reversed(sublime.windows())
        if window.id() != active_window.id()
    }

    sorted_jump_history = dict(
        sorted(
            jump_history_dict.items(),
            key=lambda item: item[1].last_change_time,
            reverse=True,
        )
    )

    sorted_windows = []

    for window_id in sorted_jump_history:
        if window := inactive_windows.get(window_id):
            sorted_windows.append(window)

    for window_id, window in inactive_windows.items():
        if window_id not in sorted_jump_history:
            sorted_windows.append(window)

    sorted_windows.append(active_window)

    return sorted_windows


class WindowInputHandler(sublime_plugin.ListInputHandler):
    def name(self) -> str:
        return "window_id"

    def placeholder(self) -> str:
        return "Choose a window"

    def list_items(self):
        def active_file(window):
            if not (view := window.active_view()):
                return (None, None)

            if not (file_name := view.file_name()):
                return (None, view.name())

            file = Path(file_name)
            return (file.parent, file.name)

        def active_folder(folders, active_file_path):
            if active_file_path:
                for folder in folders:
                    try:
                        folder = Path(folder)
                        active_file_path.relative_to(folder)
                        return folder
                    except ValueError:
                        continue
            return Path(folders[0])

        def transform_folder(folder):
            try:
                home = "USERPROFILE" if os.name == "nt" else "HOME"
                return f"~{os.sep}{folder.relative_to(os.getenv(home, ''))}"
            except ValueError:
                return folder

        def create_item(window):
            active_file_path, active_file_name = active_file(window)
            folders = window.folders()
            workspace = window.workspace_file_name()

            if workspace:
                title = Path(workspace).stem
                kind = [sublime.KIND_ID_NAMESPACE, "P", "Project"]
                if folders:
                    second_line = transform_folder(
                        active_folder(folders, active_file_path)
                    )
                else:
                    second_line = "No folders in project yet!"

            elif folders:
                folder = active_folder(folders, active_file_path)
                title = folder.name
                kind = [sublime.KIND_ID_NAVIGATION, "F", "Folder"]
                second_line = transform_folder(folder)

            elif active_file_path:
                title = active_file_name
                kind = [sublime.KIND_ID_NAVIGATION, "f", "File"]
                second_line = transform_folder(active_file_path)

            else:
                title = active_file_name
                kind = [sublime.KIND_ID_AMBIGUOUS, "S", "Scratch"]
                second_line = "Scratch Window"

            return sublime.ListInputItem(
                text=title or "untitled",
                value=window.id(),
                annotation=f"Window {window.id()}",
                kind=kind,
                details=[f"<i>{second_line}</i>"],
            )

        return [create_item(window) for window in recent_window_history()]


class SwitchWindowCommand(sublime_plugin.ApplicationCommand):
    def input_description(self) -> str:
        return "Switch Window"

    def input(self, args) -> WindowInputHandler | None:
        return WindowInputHandler() if args.get("window_id") is None else None

    def run(self, window_id: int | None = None):
        for window in sublime.windows():
            if window.id() == window_id:
                window.bring_to_front()
                break


class SwitchToPreviousWindowCommand(sublime_plugin.ApplicationCommand):
    def run(self):
        if previous_window := next(iter(recent_window_history()), None):
            previous_window.bring_to_front()
