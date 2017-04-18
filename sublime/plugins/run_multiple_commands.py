import sublime
import sublime_plugin


class RunMultipleCommandsCommand(sublime_plugin.TextCommand):
    def run(self, edit, commands=[]):
        for command in commands:
            if 'command' not in command:
                raise Exception('No command name provided.')

            args = None
            if 'args' in command:
                args = command['args']

            context = self.view
            if 'context' in command:
                context_name = command['context']
                if context_name == 'window':
                    context = context.window()
                elif context_name == 'app':
                    context = sublime
                elif context_name == 'text':
                    context = self.view

            print('Running command:', command['command'])
            if args is None:
                context.run_command(command['command'])
            else:
                context.run_command(command['command'], args)
