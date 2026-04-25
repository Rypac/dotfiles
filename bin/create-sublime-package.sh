#!/bin/sh

package="$1.sublime-package"

echo "3.14" > .python-version

zip -r "$HOME/Library/Application Support/Sublime Text/Installed Packages/$package" . -x \
    ".gitignore" \
    ".gitattributes" \
    ".DS_Store" \
    ".git/*" \
    ".github/*" \
    ".editorconfig" \
    "sublime-package.json" \
    "pyrightconfig.json" \
    "pyproject.toml" \
    "mypy.ini" \
    "tox.ini" \
    "requirements.txt" \
    "tests/*" \
    "dependencies.json" \
    "messages/*" \
    "messages.json" \
    "README.md" \
    "LICENSE" \
    "CONTRIBUTING.md" \
    "CONTRIBUTORS.md" \
    "COPYRIGHT.txt"
