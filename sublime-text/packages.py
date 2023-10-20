from __future__ import annotations

import sublime
import sublime_plugin

from enum import Enum, auto
import os


class PackageViewer:
    def installed_packages(self) -> set[str]:
        installed_packages_path = sublime.installed_packages_path()
        installed_packages = set(
            package[: -len(".sublime-package")]
            for package in os.listdir(installed_packages_path)
            if package.endswith(".sublime-package")
            and not os.path.isdir(os.path.join(installed_packages_path, package))
        )

        packages_path = sublime.packages_path()
        packages = set(
            package
            for package in os.listdir(packages_path)
            if package.casefold() != "User".casefold()
            and package.casefold() != "Default".casefold()
            and os.path.isdir(os.path.join(packages_path, package))
        )

        return installed_packages | packages


class PackageManager(PackageViewer):
    def update_package(self, package: str, enabled: bool):
        state = "enabled" if enabled else "disabled"

        packages = self.installed_packages()
        if package not in packages:
            sublime.status_message(f"{package} is not installed")
            return

        settings = sublime.load_settings("Preferences.sublime-settings")
        ignored_packages = settings.get("ignored_packages", [])

        if enabled and package in ignored_packages:
            ignored_packages.remove(package)
        elif not enabled and package not in ignored_packages:
            ignored_packages.append(package)
        else:
            sublime.status_message(f"{package} is already {state}")
            return

        ignored_packages.sort()
        settings.set("ignored_packages", ignored_packages)
        sublime.save_settings("Preferences.sublime-settings")

        sublime.status_message(f"{package} {state}")


class PackageFilter(Enum):
    ALL = auto()
    ENABLED = auto()
    DISABLED = auto()


class ListPackagesInputHandler(sublime_plugin.ListInputHandler, PackageViewer):
    def __init__(self, filter: PackageFilter):
        self.filter = filter

    def name(self) -> str:
        return "name"

    def list_items(self) -> [str | sublime.ListInputItem]:
        installed_packages = self.installed_packages()

        settings = sublime.load_settings("Preferences.sublime-settings")
        ignored_packages = set(settings.get("ignored_packages", []))

        if self.filter is PackageFilter.ALL:
            return [
                sublime.ListInputItem(
                    text=package,
                    value=package,
                    annotation="Enabled"
                    if package not in ignored_packages
                    else "Disabled",
                )
                for package in sorted(installed_packages)
            ]
        elif self.filter is PackageFilter.ENABLED:
            return sorted(installed_packages - ignored_packages)
        elif self.filter is PackageFilter.DISABLED:
            return sorted(installed_packages & ignored_packages)


class ListPackagesCommand(sublime_plugin.ApplicationCommand, PackageViewer):
    def run(self, **kwargs):
        installed_packages = sorted(self.installed_packages())
        print(f"Installed packages: {installed_packages}")

    def input(self, args) -> sublime_plugin.CommandInputHandler | None:
        return (
            ListPackagesInputHandler(filter=PackageFilter.ALL)
            if args.get("name") is None
            else None
        )


class EnablePackageCommand(sublime_plugin.ApplicationCommand, PackageManager):
    def run(self, **kwargs):
        if name := kwargs.get("name"):
            self.update_package(package=name, enabled=True)
        else:
            print("Specify package to enable with 'name' argument")

    def input(self, args) -> sublime_plugin.CommandInputHandler | None:
        return (
            ListPackagesInputHandler(filter=PackageFilter.DISABLED)
            if args.get("name") is None
            else None
        )


class DisablePackageCommand(sublime_plugin.ApplicationCommand, PackageManager):
    def run(self, **kwargs):
        if name := kwargs.get("name"):
            self.update_package(package=name, enabled=False)
        else:
            print("Specify package to disable with 'name' argument")

    def input(self, args) -> sublime_plugin.CommandInputHandler | None:
        return (
            ListPackagesInputHandler(filter=PackageFilter.ENABLED)
            if args.get("name") is None
            else None
        )
