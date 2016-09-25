import sublime
import sublime_plugin


class ToggleVintageousCommand(sublime_plugin.WindowCommand):
    def run(self):
        settings = sublime.load_settings('Preferences.sublime-settings')
        ignored = settings.get('ignored_packages')

        if 'Vintageous' in ignored:
            ignored.remove('Vintageous')
        else:
            ignored.append('Vintageous')

        settings.set('ignored_packages', ignored)
        sublime.save_settings('Preferences.sublime-settings')
