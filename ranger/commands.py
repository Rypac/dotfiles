from ranger.api.commands import Command

import os
import subprocess


class finder(Command):
    """
    :finder

    Present selected files in finder
    """

    def execute(self):
        self.fm.run('open .', flags='f')


class z(Command):
    """
    :z <directory>

    Jump to directory using z
    """

    def execute(self):
        args = self.rest(1)
        if args:
            command = ["z"] + args.split()
            directory = subprocess.check_output(
                command, universal_newlines=True).strip()
            self.fm.cd(directory)


class fzf(Command):
    """
    :fzf

    Find a file using fzf.

    With a prefix argument select only directories.
    """

    def execute(self):
        if self.quantifier:
            # match only directories
            command = "find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"

        else:
            # match files and directories
            command = "find -L . \( -path '*/\.*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
            -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"

        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode('utf-8').rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)
