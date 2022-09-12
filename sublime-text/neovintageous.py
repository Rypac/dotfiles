import sublime
import sublime_plugin


class ToggleNeovintageousCommand(sublime_plugin.ApplicationCommand):
    def run(self):
        settings = sublime.load_settings("Preferences.sublime-settings")
        ignored_packages = settings.get("ignored_packages", [])

        if was_ignored := "NeoVintageous" in ignored_packages:
            ignored_packages.remove("NeoVintageous")
        else:
            ignored_packages.append("NeoVintageous")

        ignored_packages.sort()
        settings.set("ignored_packages", ignored_packages)
        sublime.save_settings("Preferences.sublime-settings")

        status = "enabled" if was_ignored else "disabled"
        sublime.status_message(f"NeoVintageous {status}")
