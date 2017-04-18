import sublime
import sublime_plugin


class ToggleVimModeCommand(sublime_plugin.WindowCommand):
    def run(self):
        settings = sublime.load_settings('Preferences.sublime-settings')
        ignored = settings.get('ignored_packages')

        if 'NeoVintageous' in ignored:
            ignored.remove('NeoVintageous')
        else:
            ignored.append('NeoVintageous')

        settings.set('ignored_packages', ignored)
        sublime.save_settings('Preferences.sublime-settings')
