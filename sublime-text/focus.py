import sublime
import sublime_plugin


def plugin_unloaded():
    for window in sublime.windows():
        if window.settings().has("focus_mode_state"):
            exit_focus_mode(window)


def enter_focus_mode(window: sublime.Window):
    for view in window.views(include_transient=True):
        enter_view_focus_mode(view)

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


def exit_focus_mode(window: sublime.Window):
    for view in window.views(include_transient=True):
        exit_view_focus_mode(view)

    pre_focus_state = window.settings().get("focus_mode_state", {})

    window.set_minimap_visible(pre_focus_state.get("minimap", True))
    window.set_sidebar_visible(pre_focus_state.get("sidebar", True))
    window.set_status_bar_visible(pre_focus_state.get("status_bar", True))
    window.set_tabs_visible(pre_focus_state.get("tabs", True))

    window.settings().erase("focus_mode_state")


def enter_view_focus_mode(view: sublime.View):
    view_settings = view.settings()

    if view_settings.has("focus_mode_state"):
        return

    df_settings = sublime.load_settings("Distraction Free.sublime-settings")

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

    pre_focus_state = {}

    for key, value in focus_mode_settings.items():
        pre_focus_state[key] = view_settings.get(key)
        view_settings.set(key, df_settings.get(key, value))

    view_settings.set("focus_mode_state", pre_focus_state)


def exit_view_focus_mode(view: sublime.View):
    view_settings = view.settings()

    if (pre_focus_state := view_settings.get("focus_mode_state")) is not None:
        view_settings.update(pre_focus_state)
        view_settings.erase("focus_mode_state")


class FocusModeListener(sublime_plugin.EventListener):
    def on_new(self, view: sublime.View):
        if (window := view.window()) is None:
            return

        if window.settings().has("focus_mode_state"):
            enter_view_focus_mode(view)

    def on_load(self, view: sublime.View):
        if (window := view.window()) is None:
            return

        if window.settings().has("focus_mode_state"):
            enter_view_focus_mode(view)
        else:
            exit_view_focus_mode(view)


class FocusModeCommand(sublime_plugin.WindowCommand):
    def run(self, enable: bool = True):
        if enable:
            enter_focus_mode(self.window)
        else:
            exit_focus_mode(self.window)

    def is_enabled(self, enable: bool = True) -> bool:
        return self.window.settings().has("focus_mode_state") != enable
