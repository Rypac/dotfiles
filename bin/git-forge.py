#!/usr/bin/env python3
#
# /// script
# requires-python = ">=3.8"
# dependencies = []
# ///
"""
git-forge — open your Git remote in a browser.

Usage (via git):
    git forge                          # repository home
    git forge commit <sha>             # specific commit
    git forge branch [<name>]          # branch or branch list
    git forge tag [<name>]             # tag or tag list
    git forge diff <ref1> [<ref2>]     # diff between refs / branches
    git forge pr [<number>]            # pull request or pull request list
    git forge issue [<number>]         # issue or issue list
    git forge file <path> [--line <n>] # file, optionally at a line
    git forge release [<tag>]          # release or release list

Supported forges: GitHub, GitLab, Bitbucket.
"""

from __future__ import annotations

import re
import subprocess
from argparse import ArgumentParser, Namespace
from dataclasses import dataclass
from subprocess import CalledProcessError
from typing import Callable, Protocol
from urllib.parse import quote as url_quote

# ---------------------------------------------------------------------------
# Remote
# ---------------------------------------------------------------------------


@dataclass(frozen=True)
class Remote:
    host: str
    namespace: str
    repository: str

    @property
    def url(self) -> str:
        return f"https://{self.host}/{self.namespace}/{self.repository}"


def parse_remote(url: str) -> Remote:
    for remote_pattern in (
        r"https://([^/]+)/(.+?)(\.git)?$",
        r"git@([^:]+):(.+?)(\.git)?$",
    ):
        if match := re.match(remote_pattern, url):
            host = match.group(1)
            path = match.group(2)

            namespace, repository = path.rsplit("/", 1)

            return Remote(
                host=host,
                namespace=namespace,
                repository=repository,
            )

    raise SystemExit(f"error: unsupported remote: {url}")


# ---------------------------------------------------------------------------
# Forge
# ---------------------------------------------------------------------------


class GitForge(Protocol):
    """URL factory for a Git hosting forge.

    Each implementation is constructed with a ``Remote`` and exposes methods
    that return fully-qualified URLs for every browsable resource.  The
    ``Remote`` is intentionally not part of the method signatures — callers
    work with a ``Forge`` without needing to pass context on every call.
    """

    def home(self) -> str: ...
    def commit(self, sha: str) -> str: ...
    def branch(self, name: str) -> str: ...
    def branches(self) -> str: ...
    def tag(self, name: str) -> str: ...
    def tags(self) -> str: ...
    def diff(self, base: str, head: str) -> str: ...
    def file(self, path: str, ref: str, line: int | None) -> str: ...
    def pull_request(self, number: int) -> str: ...
    def pull_requests(self) -> str: ...
    def issue(self, number: int) -> str: ...
    def issues(self) -> str: ...
    def release(self, tag: str) -> str: ...
    def releases(self) -> str: ...


class GithubForge(GitForge):
    def __init__(self, remote: Remote) -> None:
        self.remote = remote

    def home(self) -> str:
        return self.remote.url

    def commit(self, sha: str) -> str:
        return f"{self.remote.url}/commit/{sha}"

    def branch(self, name: str) -> str:
        return f"{self.remote.url}/tree/{url_quote(name, safe='/@')}"

    def branches(self) -> str:
        return f"{self.remote.url}/branches"

    def tag(self, name: str) -> str:
        return f"{self.remote.url}/tree/{url_quote(name, safe='/@')}"

    def tags(self) -> str:
        return f"{self.remote.url}/tags"

    def diff(self, base: str, head: str) -> str:
        return f"{self.remote.url}/compare/{url_quote(base, safe='/@')}...{url_quote(head, safe='/@')}"

    def file(self, path: str, ref: str, line: int | None) -> str:
        url = f"{self.remote.url}/blob/{url_quote(ref, safe='/@')}/{url_quote(path.lstrip('/'))}"
        if line is not None:
            url += f"#L{line}"
        return url

    def pull_request(self, number: int) -> str:
        return f"{self.remote.url}/pull/{number}"

    def pull_requests(self) -> str:
        return f"{self.remote.url}/pulls"

    def issue(self, number: int) -> str:
        return f"{self.remote.url}/issues/{number}"

    def issues(self) -> str:
        return f"{self.remote.url}/issues"

    def release(self, tag: str) -> str:
        return f"{self.remote.url}/releases/tag/{url_quote(tag, safe='')}"

    def releases(self) -> str:
        return f"{self.remote.url}/releases"


class GitlabForge(GitForge):
    def __init__(self, remote: Remote) -> None:
        self.remote = remote

    def home(self) -> str:
        return self.remote.url

    def commit(self, sha: str) -> str:
        return f"{self.remote.url}/-/commit/{sha}"

    def branch(self, name: str) -> str:
        return f"{self.remote.url}/-/tree/{url_quote(name, safe='/@')}"

    def branches(self) -> str:
        return f"{self.remote.url}/-/branches"

    def tag(self, name: str) -> str:
        return f"{self.remote.url}/-/tree/{url_quote(name, safe='/@')}"

    def tags(self) -> str:
        return f"{self.remote.url}/-/tags"

    def diff(self, base: str, head: str) -> str:
        return f"{self.remote.url}/-/compare/{url_quote(base, safe='/@')}...{url_quote(head, safe='/@')}"

    def file(self, path: str, ref: str, line: int | None) -> str:
        url = f"{self.remote.url}/-/blob/{url_quote(ref, safe='/@')}/{url_quote(path.lstrip('/'))}"
        if line is not None:
            url += f"#L{line}"
        return url

    def pull_request(self, number: int) -> str:
        return f"{self.remote.url}/-/merge_requests/{number}"

    def pull_requests(self) -> str:
        return f"{self.remote.url}/-/merge_requests"

    def issue(self, number: int) -> str:
        return f"{self.remote.url}/-/issues/{number}"

    def issues(self) -> str:
        return f"{self.remote.url}/-/issues"

    def release(self, tag: str) -> str:
        return f"{self.remote.url}/-/releases/{url_quote(tag, safe='')}"

    def releases(self) -> str:
        return f"{self.remote.url}/-/releases"


class BitbucketForge(GitForge):
    def __init__(self, remote: Remote) -> None:
        self.remote = remote

    def home(self) -> str:
        return self.remote.url

    def commit(self, sha: str) -> str:
        return f"{self.remote.url}/commits/{sha}"

    def branch(self, name: str) -> str:
        return f"{self.remote.url}/src/{url_quote(name, safe='/@')}"

    def branches(self) -> str:
        return f"{self.remote.url}/branches"

    def tag(self, name: str) -> str:
        return f"{self.remote.url}/src/{url_quote(name, safe='/@')}"

    def tags(self) -> str:
        return f"{self.remote.url}/refs/tags"

    def diff(self, base: str, head: str) -> str:
        return f"{self.remote.url}/branches/compare/{url_quote(head, safe='/@')}..{url_quote(base, safe='/@')}"

    def file(self, path: str, ref: str, line: int | None) -> str:
        url = f"{self.remote.url}/src/{url_quote(ref, safe='/@')}/{url_quote(path.lstrip('/'))}"
        if line is not None:
            url += f"#lines-{line}"
        return url

    def pull_request(self, number: int) -> str:
        return f"{self.remote.url}/pull-requests/{number}"

    def pull_requests(self) -> str:
        return f"{self.remote.url}/pull-requests"

    def issue(self, number: int) -> str:
        return f"{self.remote.url}/issues/{number}"

    def issues(self) -> str:
        return f"{self.remote.url}/issues"

    def release(self, tag: str) -> str:
        return f"{self.remote.url}/downloads"

    def releases(self) -> str:
        return f"{self.remote.url}/downloads"


def resolve_forge(remote: Remote) -> GitForge:
    forge_registry = {
        "github": (GithubForge, "github.com"),
        "gitlab": (GitlabForge, "gitlab.com"),
        "bitbucket": (BitbucketForge, "bitbucket.org"),
    }

    if config := git_config(f"forge.host.{remote.host}.type"):
        try:
            forge, _ = forge_registry[config.lower()]
            return forge(remote)
        except KeyError:
            raise SystemExit(f"error: unsupported forge: {config.lower()}")

    for forge, host in forge_registry.values():
        if host == remote.host:
            return forge(remote)

    raise SystemExit(f"error: unsupported forge: {remote.host}")


# ---------------------------------------------------------------------------
# Git
# ---------------------------------------------------------------------------


def git(*args: str) -> str:
    result = subprocess.run(["git", *args], capture_output=True, text=True, check=True)
    return result.stdout.strip()


def git_config(key: str) -> str | None:
    try:
        return git("config", "--get", key)
    except CalledProcessError:
        return None


def git_remote_url(remote: str) -> str:
    try:
        return git("remote", "get-url", remote)
    except CalledProcessError:
        raise SystemExit(f"error: remote '{remote}' not found")


def git_current_branch() -> str | None:
    try:
        branch = git("rev-parse", "--abbrev-ref", "HEAD")
        return branch if branch != "HEAD" else None
    except CalledProcessError:
        return None


def git_head() -> str:
    try:
        return git("rev-parse", "HEAD")
    except CalledProcessError:
        raise SystemExit("error: unable to reach HEAD")


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------


def build_parser() -> ArgumentParser:
    parser = ArgumentParser(
        prog="git forge",
        description="Open your Git remote in a browser.",
    )

    parser.add_argument(
        "--remote",
        default="origin",
        metavar="NAME",
        help="Git remote to use (default: origin)",
    )

    return parser


def register_commands(parser: ArgumentParser) -> Callable[[Namespace, GitForge], str]:
    command_subparsers = parser.add_subparsers(dest="command")

    def command(**kwargs):
        def decorator(fn):
            command_name = kwargs.pop("name", fn.__name__)
            command_parser = command_subparsers.add_parser(command_name, **kwargs)
            for flags, argument_kwargs in reversed(getattr(fn, "_arguments", [])):
                command_parser.add_argument(*flags, **argument_kwargs)
            command_parser.set_defaults(command_fn=fn)
            return fn

        return decorator

    def argument(*flags, **kwargs):
        def decorator(fn):
            if not hasattr(fn, "_arguments"):
                fn._arguments = []
            fn._arguments.append((flags, kwargs))
            return fn

        return decorator

    def command_handler(args: Namespace, forge: GitForge) -> str:
        return args.command_fn(args, forge) if args.command else forge.home()

    # -- commands --

    @command(help="Open a specific commit")
    @argument("sha", help="Commit SHA (full or abbreviated)")
    def commit(args: Namespace, forge: GitForge) -> str:
        return forge.commit(args.sha)

    @command(help="Open a branch, or the branch list when omitted")
    @argument("name", nargs="?", help="Branch name")
    def branch(args: Namespace, forge: GitForge) -> str:
        if args.name:
            return forge.branch(args.name)
        return forge.branches()

    @command(help="Open a file in the remote browser")
    @argument("path", help="File path relative to repository root")
    @argument("--line", type=int, help="Jump to a specific line")
    @argument(
        "--permalink",
        nargs="?",
        const="HEAD",
        help="Use permanent link to file (HEAD if empty)",
    )
    def file(args: Namespace, forge: GitForge) -> str:
        if permalink := args.permalink:
            ref = git_head() if permalink == "HEAD" else permalink
        else:
            ref = git_current_branch() or git_head()
        return forge.file(args.path, ref, args.line)

    @command(help="Open a tag, or the tag list when omitted")
    @argument("name", nargs="?", help="Tag name")
    def tag(args: Namespace, forge: GitForge) -> str:
        if args.name:
            return forge.tag(args.name)
        return forge.tags()

    @command(help="Open a diff between two refs")
    @argument(
        "refs",
        nargs="+",
        metavar="REF",
        help="One arg 'base..head', or two args 'base' 'head'",
    )
    def diff(args: Namespace, forge: GitForge) -> str:
        if len(args.refs) == 1 and ".." in args.refs[0]:
            base, _, head = args.refs[0].partition("..")
            return forge.diff(base, head)
        elif len(args.refs) == 2:
            base, head = args.refs
            return forge.diff(base, head)
        else:
            raise SystemExit("error: diff requires 'base..head' or two ref arguments")

    @command(help="Open a pull request, or the pull request list when omitted")
    @argument("number", nargs="?", type=int, help="PR number")
    def pr(args: Namespace, forge: GitForge) -> str:
        if args.number is not None:
            return forge.pull_request(args.number)
        return forge.pull_requests()

    @command(help="Open an issue, or the issue list when omitted")
    @argument("number", nargs="?", type=int, help="Issue number")
    def issue(args: Namespace, forge: GitForge) -> str:
        if args.number is not None:
            return forge.issue(args.number)
        return forge.issues()

    @command(help="Open a release, or the release list when omitted")
    @argument("tag", nargs="?", help="Release tag")
    def release(args: Namespace, forge: GitForge) -> str:
        if args.tag:
            return forge.release(args.tag)
        return forge.releases()

    return command_handler


def register_actions(parser: ArgumentParser) -> Callable[[Namespace, str], None]:
    action_group_container = parser.add_argument_group("action arguments")
    action_group = action_group_container.add_mutually_exclusive_group()

    def action(*flags: str, help: str, default: bool = False):
        def decorator(fn):
            action_group.add_argument(
                *flags,
                dest="action_fn",
                action="store_const",
                const=fn,
                default=fn if default else None,
                help=help,
            )
            return fn

        return decorator

    def action_handler(args: Namespace, url: str) -> None:
        args.action_fn(url)

    # -- actions --

    @action("--open", "-o", help="Open URL in default browser", default=True)
    def open_url(url: str) -> None:
        import webbrowser

        webbrowser.open(url)

    @action("--copy", "-c", help="Copy URL to the clipboard")
    def copy_url(url: str) -> None:
        import sys

        if sys.platform == "darwin":
            subprocess.run(["pbcopy"], input=url, text=True, check=True)
        elif sys.platform == "win32":
            subprocess.run(["clip"], input=url, text=True, check=True)
        else:
            for clipboard_command in (
                ["wl-copy"],
                ["xclip", "-selection", "clipboard"],
                ["xsel", "--clipboard", "--input"],
            ):
                try:
                    subprocess.run(clipboard_command, input=url, text=True, check=True)
                    break
                except (FileNotFoundError, CalledProcessError):
                    continue
            else:
                raise SystemExit("error: no clipboard utility found")

    @action("--print", "-p", help="Print URL")
    def print_url(url: str) -> None:
        print(url)

    return action_handler


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------


def main(argv: list[str] | None = None) -> None:
    parser = build_parser()
    command_handler = register_commands(parser)
    action_handler = register_actions(parser)
    args = parser.parse_args(argv)

    remote_url = git_remote_url(args.remote)
    remote = parse_remote(remote_url)
    forge = resolve_forge(remote)

    url = command_handler(args, forge)
    action_handler(args, url)


if __name__ == "__main__":
    import sys

    main(sys.argv[1:])
