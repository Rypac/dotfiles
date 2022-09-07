import sublime
import sublime_plugin


def set_view_setting(view_prefs, df_prefs, setting, default):
    view_prefs.set(setting, df_prefs.get(setting, default))


def reset_view_setting(view_prefs, syntax_prefs, prefs, setting, default):
    if syntax_prefs is not None:
        view_prefs.set(setting, syntax_prefs.get(setting, prefs.get(setting, default)))
    else:
        view_prefs.set(setting, prefs.get(setting, default))


class EnterFocusModeCommand(sublime_plugin.WindowCommand):
    def run(self):
        df_prefs = sublime.load_settings("Distraction Free.sublime-settings")

        for view in self.window.views():
            view_prefs = view.settings()
            if view_prefs is None:
                continue

            set_view_setting(view_prefs, df_prefs, "draw_centered", True)
            set_view_setting(view_prefs, df_prefs, "draw_indent_guides", True)
            set_view_setting(view_prefs, df_prefs, "indent_guide_options", [])
            set_view_setting(view_prefs, df_prefs, "draw_white_space", "selection")
            set_view_setting(view_prefs, df_prefs, "fold_buttons", False)
            set_view_setting(view_prefs, df_prefs, "gutter", False)
            set_view_setting(view_prefs, df_prefs, "line_numbers", False)
            set_view_setting(view_prefs, df_prefs, "rulers", [])
            set_view_setting(view_prefs, df_prefs, "scroll_past_end", True)
            set_view_setting(view_prefs, df_prefs, "word_wrap", True)
            set_view_setting(view_prefs, df_prefs, "wrap_width", 80)

        self.window.set_tabs_visible(False)
        self.window.set_status_bar_visible(False)
        self.window.set_sidebar_visible(False)
        self.window.set_minimap_visible(False)


class ExitFocusModeCommand(sublime_plugin.WindowCommand):
    def run(self):
        prefs = sublime.load_settings("Preferences.sublime-settings")

        for view in self.window.views():
            view_prefs = view.settings()
            if view_prefs is None:
                continue

            syntax = view_prefs.get("syntax").split("/")[-1].split(".")[0]
            syntax_prefs = sublime.load_settings(syntax + ".sublime-settings") if syntax is not None else None
            reset_view_setting(view_prefs, syntax_prefs, prefs, "draw_centered", False)
            reset_view_setting(view_prefs, syntax_prefs, prefs, "draw_indent_guides", True)
            reset_view_setting(view_prefs, syntax_prefs, prefs, "draw_white_space", "selection")
            reset_view_setting(view_prefs, syntax_prefs, prefs, "fold_buttons", True)
            reset_view_setting(view_prefs, syntax_prefs, prefs, "gutter", True)
            reset_view_setting(view_prefs, syntax_prefs, prefs, "line_numbers", True)
            reset_view_setting(view_prefs, syntax_prefs, prefs, "rulers",[])
            reset_view_setting(view_prefs, syntax_prefs, prefs, "scroll_past_end", False)
            reset_view_setting(view_prefs, syntax_prefs, prefs, "word_wrap", "auto")
            reset_view_setting(view_prefs, syntax_prefs, prefs, "wrap_width", 0)

        self.window.set_tabs_visible(True)
        self.window.set_status_bar_visible(True)
        self.window.set_sidebar_visible(True)
        self.window.set_minimap_visible(True)
