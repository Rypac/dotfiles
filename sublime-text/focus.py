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

        self.window.set_tabs_visible(False)
        self.window.set_status_bar_visible(False)
        self.window.set_sidebar_visible(False)
        self.window.set_minimap_visible(False)


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
            syntax_prefs = sublime.load_settings(f"{syntax}.sublime-settings") if syntax is not None else None
            
            if syntax_prefs is not None:
                for setting, default in focus_prefs.items():
                    view_prefs.set(setting, syntax_prefs.get(setting, prefs.get(setting, default)))
            else:
                for setting, default in focus_prefs.items():
                    view_prefs.set(setting, prefs.get(setting, default))

        self.window.set_tabs_visible(True)
        self.window.set_status_bar_visible(True)
        self.window.set_sidebar_visible(True)
        self.window.set_minimap_visible(True)
