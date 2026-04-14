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

import logging
import re
import subprocess
from argparse import ArgumentParser, Namespace
from dataclasses import dataclass
from pathlib import Path
from subprocess import CalledProcessError
from typing import Callable, Protocol
from urllib.parse import quote as url_quote

logger = logging.getLogger(__name__)

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

    raise ValueError(f"Unsupported remote: {url}")


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


class GithubForge:
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
        url = f"{self.remote.url}/blob/{url_quote(ref, safe='/@')}/{url_quote(path.lstrip('/'), safe='/')}"
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


class GitlabForge:
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
        url = f"{self.remote.url}/-/blob/{url_quote(ref, safe='/@')}/{url_quote(path.lstrip('/'), safe='/')}"
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


class BitbucketForge:
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
        url = f"{self.remote.url}/src/{url_quote(ref, safe='/@')}/{url_quote(path.lstrip('/'), safe='/')}"
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
        # Bitbucket has no per-release page; link to the tag instead
        return f"{self.remote.url}/src/{url_quote(tag, safe='')}"

    def releases(self) -> str:
        return f"{self.remote.url}/downloads"


_FORGE_BY_TYPE: dict[str, type[GitForge]] = {
    "github": GithubForge,
    "gitlab": GitlabForge,
    "bitbucket": BitbucketForge,
}

_FORGE_BY_HOST: dict[str, type[GitForge]] = {
    "github.com": GithubForge,
    "gitlab.com": GitlabForge,
    "bitbucket.org": BitbucketForge,
}


def resolve_forge(remote: Remote) -> GitForge:
    if config := git_config_get(f"forge.host.{remote.host}.type"):
        try:
            return _FORGE_BY_TYPE[config.lower()](remote)
        except KeyError:
            raise ValueError(f"Unsupported forge type: {config.lower()!r}")

    try:
        return _FORGE_BY_HOST[remote.host](remote)
    except KeyError:
        raise ValueError(f"Unsupported forge host: {remote.host!r}")


# ---------------------------------------------------------------------------
# Git
# ---------------------------------------------------------------------------


def git(*args: str) -> str:
    result = subprocess.run(["git", *args], capture_output=True, text=True, check=True)
    return result.stdout.strip()


def git_config_get(key: str) -> str | None:
    try:
        return git("config", "--get", key)
    except CalledProcessError:
        return None


def git_remote_url(remote: str) -> str:
    try:
        return git("remote", "get-url", remote)
    except CalledProcessError as e:
        raise RuntimeError(f"Remote '{remote}' not found") from e


def git_current_branch() -> str | None:
    try:
        branch = git("rev-parse", "--abbrev-ref", "HEAD")
        return branch if branch != "HEAD" else None
    except CalledProcessError as e:
        raise RuntimeError("Unable to get current branch") from e


def git_head() -> str:
    try:
        return git("rev-parse", "HEAD")
    except CalledProcessError as e:
        raise RuntimeError("Unable to reach HEAD") from e


def git_root() -> str:
    try:
        return git("rev-parse", "--show-toplevel")
    except CalledProcessError as e:
        raise RuntimeError("Unable to determine repository root") from e


def repository_relative_path(path: str) -> str:
    repo_root = Path(git_root())
    candidate = Path(path)
    resolved = (
        candidate.resolve()
        if candidate.is_absolute()
        else (Path.cwd() / candidate).resolve()
    )

    try:
        relative_path = resolved.relative_to(repo_root)
    except ValueError as e:
        raise ValueError(f"File path is outside repository: {path}") from e

    return relative_path.as_posix()


# ---------------------------------------------------------------------------
# CLI — command protocol and registry
# ---------------------------------------------------------------------------


class Command(Protocol):
    name: str
    help: str

    def add_arguments(self, parser: ArgumentParser) -> None: ...
    def __call__(self, args: Namespace, forge: GitForge) -> str: ...


_COMMANDS: list[Command] = []


def command(cls: type) -> type:
    _COMMANDS.append(cls())
    return cls


# ---------------------------------------------------------------------------
# CLI — commands
# ---------------------------------------------------------------------------


@command
class CommitCommand:
    name = "commit"
    help = "Open a specific commit"

    def add_arguments(self, parser: ArgumentParser) -> None:
        parser.add_argument("sha", help="Commit SHA (full or abbreviated)")

    def __call__(self, args: Namespace, forge: GitForge) -> str:
        return forge.commit(args.sha)


@command
class BranchCommand:
    name = "branch"
    help = "Open a branch, or the branch list when omitted"

    def add_arguments(self, parser: ArgumentParser) -> None:
        parser.add_argument("name", nargs="?", help="Branch name")

    def __call__(self, args: Namespace, forge: GitForge) -> str:
        return forge.branch(args.name) if args.name is not None else forge.branches()


@command
class TagCommand:
    name = "tag"
    help = "Open a tag, or the tag list when omitted"

    def add_arguments(self, parser: ArgumentParser) -> None:
        parser.add_argument("name", nargs="?", help="Tag name")

    def __call__(self, args: Namespace, forge: GitForge) -> str:
        return forge.tag(args.name) if args.name is not None else forge.tags()


@command
class DiffCommand:
    name = "diff"
    help = "Open a diff between two refs"

    def add_arguments(self, parser: ArgumentParser) -> None:
        parser.add_argument(
            "refs",
            nargs="+",
            metavar="REF",
            help="One arg 'base..head', or two args 'base' 'head'",
        )

    def __call__(self, args: Namespace, forge: GitForge) -> str:
        if len(args.refs) == 1:
            if "..." in args.refs[0]:
                raise ValueError("Use '..' not '...' to separate diff refs")
            elif ".." not in args.refs[0]:
                raise ValueError("Use '..' to separate diff refs")

            base, _, head = args.refs[0].partition("..")
            if not base or not head:
                raise ValueError("Refs must include both base and head")
            return forge.diff(base, head)

        elif len(args.refs) == 2:
            base, head = args.refs
            if not base or not head:
                raise ValueError("Refs must include both base and head")
            return forge.diff(base, head)

        else:
            raise ValueError("Requires 'base..head' or two ref arguments")


@command
class FileCommand:
    name = "file"
    help = "Open a file in the remote browser"

    def add_arguments(self, parser: ArgumentParser) -> None:
        parser.add_argument("path", help="File path relative to repository root")
        parser.add_argument("--line", type=int, help="Jump to a specific line")
        parser.add_argument(
            "--permalink",
            nargs="?",
            const="HEAD",
            help="Use permanent link to file (HEAD if empty)",
            metavar="REF",
        )

    def __call__(self, args: Namespace, forge: GitForge) -> str:
        if args.line is not None and args.line < 1:
            raise ValueError("line must be >= 1")

        if (permalink := args.permalink) is not None:
            ref = git_head() if permalink == "HEAD" else permalink
        else:
            ref = git_current_branch() or git_head()

        return forge.file(repository_relative_path(args.path), ref, args.line)


@command
class PullRequestCommand:
    name = "pr"
    help = "Open a pull request, or the pull request list when omitted"

    def add_arguments(self, parser: ArgumentParser) -> None:
        parser.add_argument("number", nargs="?", type=int, help="PR number")

    def __call__(self, args: Namespace, forge: GitForge) -> str:
        return (
            forge.pull_request(args.number)
            if args.number is not None
            else forge.pull_requests()
        )


@command
class IssueCommand:
    name = "issue"
    help = "Open an issue, or the issue list when omitted"

    def add_arguments(self, parser: ArgumentParser) -> None:
        parser.add_argument("number", nargs="?", type=int, help="Issue number")

    def __call__(self, args: Namespace, forge: GitForge) -> str:
        return forge.issue(args.number) if args.number is not None else forge.issues()


@command
class ReleaseCommand:
    name = "release"
    help = "Open a release, or the release list when omitted"

    def add_arguments(self, parser: ArgumentParser) -> None:
        parser.add_argument("tag", nargs="?", help="Release tag")

    def __call__(self, args: Namespace, forge: GitForge) -> str:
        return forge.release(args.tag) if args.tag is not None else forge.releases()


# ---------------------------------------------------------------------------
# CLI — action protocol and registry
# ---------------------------------------------------------------------------


class Action(Protocol):
    flags: tuple[str, ...]
    help: str

    def __call__(self, url: str) -> None: ...


_ACTIONS: list[Action] = []
_DEFAULT_ACTION: Action | None = None


def action(
    cls: type | None = None,
    *,
    default: bool = False,
) -> type | Callable[[type], type]:
    def decorator(cls: type) -> type:
        global _DEFAULT_ACTION
        instance = cls()
        _ACTIONS.append(instance)
        if default:
            _DEFAULT_ACTION = instance
        return cls

    return decorator(cls) if cls is not None else decorator


# ---------------------------------------------------------------------------
# CLI — actions
# ---------------------------------------------------------------------------


@action(default=True)
class OpenAction:
    flags = ("--open", "-o")
    help = "Open URL in default browser (default)"

    def __call__(self, url: str) -> None:
        import webbrowser

        webbrowser.open(url)


@action
class CopyAction:
    flags = ("--copy", "-c")
    help = "Copy URL to the clipboard"

    def __call__(self, url: str) -> None:
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
                raise RuntimeError("No clipboard utility found")


@action
class PrintAction:
    flags = ("--print", "-p")
    help = "Print URL"

    def __call__(self, url: str) -> None:
        print(url)


# ---------------------------------------------------------------------------
# CLI - parser
# ---------------------------------------------------------------------------


def build_parser() -> ArgumentParser:
    parser = ArgumentParser(
        prog="git forge",
        description="Open your Git remote in a browser.",
    )

    parser.add_argument("--verbose", "-v", action="store_true")
    parser.add_argument(
        "--remote",
        default="origin",
        metavar="NAME",
        help="Git remote to use (default: origin)",
    )

    subparsers = parser.add_subparsers(dest="command")
    for command in _COMMANDS:
        command_parser = subparsers.add_parser(command.name, help=command.help)
        command.add_arguments(command_parser)
        command_parser.set_defaults(command_fn=command)

    group = parser.add_argument_group("action arguments").add_mutually_exclusive_group()
    parser.set_defaults(action_fn=_DEFAULT_ACTION)
    for action in _ACTIONS:
        group.add_argument(
            *action.flags,
            dest="action_fn",
            action="store_const",
            const=action,
            help=action.help,
        )

    return parser


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.INFO,
        format="%(levelname)s: %(message)s",
    )

    try:
        remote_url = git_remote_url(args.remote)
        remote = parse_remote(remote_url)
        forge = resolve_forge(remote)

        command_fn = getattr(args, "command_fn", None)
        url = command_fn(args, forge) if command_fn else forge.home()
        args.action_fn(url)
        return 0

    except ValueError as e:
        logger.error(e)
        return 2

    except Exception as e:
        logger.error(e)
        return 1


if __name__ == "__main__":
    import sys

    sys.exit(main(sys.argv[1:]))
