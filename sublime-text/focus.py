import sublime
import sublime_plugin

from typing import List


class FocusModeListener(sublime_plugin.EventListener):
    focus_mode_settings = {
        "draw_centered": True,
        "draw_indent_guides": True,
        "indent_guide_options": [],
        "draw_white_space": "selection",
        "fold_buttons": False,
        "gutter": False,
        "line_numbers": False,
        "rulers": [],
        "scroll_past_end": True,
        "word_wrap": True,
        "wrap_width": 80,
    }

    def on_init(self, views: List[sublime.View]):
        window_ids = set()
        for view in views:
            if (window := view.window()) is None:
                continue

            window_id = window.id()
            if not window_id in window_ids:
                self.on_new_window(window)
                window_ids.add(window_id)

    def on_new(self, view: sublime.View):
        if (window := view.window()) is None:
            return

        if window.settings().get("focus_mode", False):
            self.enter_view_focus_mode(view)

    def on_load(self, view: sublime.View):
        if (window := view.window()) is None:
            return

        if window.settings().get("focus_mode", False):
            self.enter_view_focus_mode(view)
        else:
            self.exit_view_focus_mode(view)

    def on_new_window(self, window: sublime.Window):
        was_in_focus_mode = window.settings().get("focus_mode", False)

        def update_focus_mode():
            nonlocal was_in_focus_mode
            now_in_focus_mode = window.settings().get("focus_mode", False)

            if not was_in_focus_mode and now_in_focus_mode:
                self.enter_focus_mode(window)
            elif was_in_focus_mode and not now_in_focus_mode:
                self.exit_focus_mode(window)

            was_in_focus_mode = now_in_focus_mode

        window.settings().add_on_change("focus_mode", update_focus_mode)

    def on_pre_close_window(self, window: sublime.Window):
        window.settings().clear_on_change("focus_mode")

    def enter_focus_mode(self, window: sublime.Window):
        for view in window.views(include_transient=True):
            self.enter_view_focus_mode(view)

        pre_focus_state = {
            "minimap": window.is_minimap_visible(),
            "sidebar": window.is_sidebar_visible(),
            "status_bar": window.is_status_bar_visible(),
            "tabs": window.get_tabs_visible(),
        }

        window.set_tabs_visible(False)
        window.set_status_bar_visible(False)
        window.set_sidebar_visible(False)
        window.set_minimap_visible(False)

        window.settings().set("focus_mode_state", pre_focus_state)

    def exit_focus_mode(self, window: sublime.Window):
        for view in window.views(include_transient=True):
            self.exit_view_focus_mode(view)

        pre_focus_state = window.settings().get("focus_mode_state", {})

        window.set_minimap_visible(pre_focus_state.get("minimap", True))
        window.set_sidebar_visible(pre_focus_state.get("sidebar", True))
        window.set_status_bar_visible(pre_focus_state.get("status_bar", True))
        window.set_tabs_visible(pre_focus_state.get("tabs", True))

        window.settings().erase("focus_mode_state")

    def enter_view_focus_mode(self, view: sublime.View):
        view_settings = view.settings()

        if view_settings.has("focus_mode_state"):
            return

        df_settings = sublime.load_settings("Distraction Free.sublime-settings")
        pre_focus_state = {}

        for key, value in self.focus_mode_settings.items():
            pre_focus_state[key] = view_settings.get(key)
            view_settings.set(key, df_settings.get(key, value))

        view_settings.set("focus_mode_state", pre_focus_state)

    def exit_view_focus_mode(self, view: sublime.View):
        view_settings = view.settings()

        if (pre_focus_state := view_settings.get("focus_mode_state")) is not None:
            view_settings.update(pre_focus_state)
            view_settings.erase("focus_mode_state")


class FocusModeCommand(sublime_plugin.WindowCommand):
    def run(self, enable: bool):
        self.window.settings().set("focus_mode", enable)

    def is_enabled(self, enable: bool) -> bool:
        return self.window.settings().get("focus_mode", False) != enable
