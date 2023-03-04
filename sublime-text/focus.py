import sublime
import sublime_plugin


class EnterFocusModeCommand(sublime_plugin.WindowCommand):
    def run(self):
        df_prefs = sublime.load_settings("Distraction Free.sublime-settings")

        focus_prefs = {
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

        for view in self.window.views():
            if (view_prefs := view.settings()) is None:
                continue

            for setting, default in focus_prefs.items():
                view_prefs.set(setting, df_prefs.get(setting, default))

        pre_focus_state = {
            "minimap": self.window.is_minimap_visible(),
            "sidebar": self.window.is_sidebar_visible(),
            "status_bar": self.window.is_status_bar_visible(),
            "tabs": self.window.get_tabs_visible(),
        }

        self.window.set_tabs_visible(False)
        self.window.set_status_bar_visible(False)
        self.window.set_sidebar_visible(False)
        self.window.set_minimap_visible(False)

        self.window.settings().set("focus_mode_state", pre_focus_state)

    def is_enabled(self) -> bool:
        return not self.window.settings().has("focus_mode_state")


class ExitFocusModeCommand(sublime_plugin.WindowCommand):
    def run(self):
        prefs = sublime.load_settings("Preferences.sublime-settings")

        focus_prefs = {
            "draw_centered": False,
            "draw_indent_guides": True,
            "draw_white_space": "selection",
            "fold_buttons": True,
            "gutter": True,
            "line_numbers": True,
            "rulers": [],
            "scroll_past_end": False,
            "word_wrap": "auto",
            "wrap_width": 0,
        }

        for view in self.window.views():
            if (view_prefs := view.settings()) is None:
                continue

            syntax = view_prefs.get("syntax").split("/")[-1].split(".")[0]
            syntax_prefs = (
                sublime.load_settings(f"{syntax}.sublime-settings")
                if syntax is not None
                else None
            )

            if syntax_prefs is not None:
                for setting, default in focus_prefs.items():
                    view_prefs.set(
                        setting,
                        syntax_prefs.get(setting, prefs.get(setting, default)),
                    )
            else:
                for setting, default in focus_prefs.items():
                    view_prefs.set(setting, prefs.get(setting, default))

        saved_state = self.window.settings().get("focus_mode_state", {})

        self.window.set_minimap_visible(saved_state.get("minimap", True))
        self.window.set_sidebar_visible(saved_state.get("sidebar", True))
        self.window.set_status_bar_visible(saved_state.get("status_bar", True))
        self.window.set_tabs_visible(saved_state.get("tabs", True))

        self.window.settings().erase("focus_mode_state")

    def is_enabled(self) -> bool:
        return self.window.settings().has("focus_mode_state")
