import sublime
import sublime_plugin

class OpenAndFocusSideBar(sublime_plugin.WindowCommand):
    def run(self):
        self.window.set_sidebar_visible(True)
        sublime.set_timeout_async(lambda: self.window.run_command('focus_side_bar'), 100)
