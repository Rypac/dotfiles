import sublime_plugin
import json
from collections import OrderedDict


class PrettifyJsonCommand(sublime_plugin.TextCommand):
    def run(self, edit, indent=4):
        for region in self.view.sel():
            if not region.empty():
                text = self.view.substr(region)
                ugly_json = json.loads(text, object_pairs_hook=OrderedDict)
                pretty_json = json.dumps(ugly_json, indent=indent)
                self.view.replace(edit, region, pretty_json)
