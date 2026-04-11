#!/usr/bin/env python3
# /// script
# requires-python = ">=3.9"
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
    git forge actions                  # CI / pipeline runs
    git forge wiki                     # project wiki
    git forge milestones               # milestone list
    git forge settings                 # repository settings

Supported forges: GitHub, GitLab, Bitbucket.
"""

from __future__ import annotations

import subprocess
from argparse import ArgumentParser, Namespace
from dataclasses import dataclass
from subprocess import CalledProcessError
from typing import Protocol
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
    def url(self):
        return f"https://{self.host}/{self.namespace}/{self.repository}"


def parse_remote(url: str) -> Remote:
    import re

    for remote_pattern in (
        r"https://([^/]+)/([^/]+)/(.+?)(\.git)?$",
        r"git@([^:]+):([^/]+)/(.+?)(\.git)?$",
    ):
        if match := re.match(remote_pattern, url):
            return Remote(
                host=match.group(1),
                namespace=match.group(2),
                repository=match.group(3),
            )
    else:
        raise SystemExit(f"error: unsupported remote URL: {url}")


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
    def actions(self) -> str: ...
    def wiki(self) -> str: ...
    def milestones(self) -> str: ...
    def settings(self) -> str: ...


@dataclass(frozen=True)
class GithubForge(GitForge):
    remote: Remote

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

    def actions(self) -> str:
        return f"{self.remote.url}/actions"

    def wiki(self) -> str:
        return f"{self.remote.url}/wiki"

    def milestones(self) -> str:
        return f"{self.remote.url}/milestones"

    def settings(self) -> str:
        return f"{self.remote.url}/settings"


@dataclass(frozen=True)
class GitlabForge(GitForge):
    remote: Remote

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

    def actions(self) -> str:
        return f"{self.remote.url}/-/pipelines"

    def wiki(self) -> str:
        return f"{self.remote.url}/-/wikis"

    def milestones(self) -> str:
        return f"{self.remote.url}/-/milestones"

    def settings(self) -> str:
        return f"{self.remote.url}/-/edit"


@dataclass(frozen=True)
class BitbucketForge(GitForge):
    remote: Remote

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

    def actions(self) -> str:
        return f"{self.remote.url}/pipelines"

    def wiki(self) -> str:
        return f"{self.remote.url}/wiki"

    def milestones(self) -> str:
        return f"{self.remote.url}/issues?milestone"

    def settings(self) -> str:
        return f"{self.remote.url}/admin"


def resolve_forge(remote: Remote) -> GitForge:
    forges = {
        "github.com": "github",
        "gitlab.com": "gitlab",
        "bitbucket.org": "bitbucket",
    }

    if remote.host not in forges:
        raise SystemExit(f"error: unsupported forge: {remote.host}")

    forge = forges[remote.host]

    if forge == "github":
        return GithubForge(remote)
    elif forge == "gitlab":
        return GitlabForge(remote)
    elif forge == "bitbucket":
        return BitbucketForge(remote)
    else:
        raise SystemExit(f"error: unsupported forge: {forge}")


# ---------------------------------------------------------------------------
# Git
# ---------------------------------------------------------------------------


def git(*args: str) -> str:
    result = subprocess.run(["git", *args], capture_output=True, text=True, check=True)
    return result.stdout.strip()


def git_remote_url(remote: str) -> str:
    try:
        return git("remote", "get-url", remote)
    except CalledProcessError:
        raise SystemExit(f"error: remote '{remote}' not found.")


def git_current_branch() -> str | None:
    try:
        return git("rev-parse", "--abbrev-ref", "HEAD")
    except CalledProcessError:
        return None


def git_head() -> str:
    try:
        return git("rev-parse", "HEAD")
    except CalledProcessError:
        raise SystemExit("error: unable to reach HEAD.")


# ---------------------------------------------------------------------------
# Action
# ---------------------------------------------------------------------------


class UrlAction(Protocol):
    def execute(self, url: str) -> None: ...


class OpenUrlAction(UrlAction):
    def execute(self, url: str) -> None:
        import webbrowser

        webbrowser.open(url)


class CopyUrlAction(UrlAction):
    def execute(self, url: str) -> None:
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


class PrintUrlAction(UrlAction):
    def execute(self, url: str) -> None:
        print(url)


def resolve_url_action(args: Namespace) -> UrlAction:
    if args.open_url:
        return OpenUrlAction()
    elif args.copy_url:
        return CopyUrlAction()
    elif args.print_url:
        return PrintUrlAction()
    else:
        return OpenUrlAction()


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

    # -- output --
    output_group = parser.add_mutually_exclusive_group()
    output_group.add_argument(
        "--open",
        dest="open_url",
        action="store_true",
        help="Open URL in default browser",
    )
    output_group.add_argument(
        "--print",
        dest="print_url",
        action="store_true",
        help="Print the URL",
    )
    output_group.add_argument(
        "--copy",
        dest="copy_url",
        action="store_true",
        help="Copy URL to the clipboard",
    )

    subparsers = parser.add_subparsers(dest="command")

    # -- commit ---------------------------------------------------------------
    parser_commit = subparsers.add_parser("commit", help="Open a specific commit")
    parser_commit.add_argument("sha", help="Commit SHA (full or abbreviated)")

    # -- branch ---------------------------------------------------------------
    parser_branch = subparsers.add_parser(
        "branch",
        help="Open a branch, or the branch list when omitted",
    )
    parser_branch.add_argument("name", nargs="?", help="Branch name")

    # -- tags -----------------------------------------------------------------
    parser_tag = subparsers.add_parser(
        "tag",
        help="Open a tag, or the tag list when omitted",
    )
    parser_tag.add_argument("name", nargs="?", help="Tag name")

    # -- diff -----------------------------------------------------------------
    parser_diff = subparsers.add_parser("diff", help="Open a diff between two refs")
    parser_diff.add_argument(
        "refs",
        nargs="+",
        metavar="REF",
        help="One arg 'base..head', or two args 'base' 'head'",
    )

    # -- file -----------------------------------------------------------------
    parser_file = subparsers.add_parser(
        "file",
        help="Open a file in the remote browser",
    )
    parser_file.add_argument("path", help="File path relative to repository root")
    parser_file.add_argument("--line", "-l", type=int, help="Jump to a specific line")
    parser_file.add_argument(
        "--ref",
        type=str,
        help="Stable ref to use for file (default current branch)",
    )

    # -- pr -------------------------------------------------------------------
    parser_pr = subparsers.add_parser(
        "pr",
        help="Open a pull request, or the pull request list when omitted",
    )
    parser_pr.add_argument("number", nargs="?", type=int, help="PR number")

    # -- issues ---------------------------------------------------------------
    parser_issue = subparsers.add_parser(
        "issue",
        help="Open an issue, or the issue list when omitted",
    )
    parser_issue.add_argument("number", nargs="?", type=int, help="Issue number")

    # -- releases -------------------------------------------------------------
    parser_release = subparsers.add_parser(
        "release",
        help="Open a release, or the release list when omitted",
    )
    parser_release.add_argument("tag", nargs="?", help="Release tag")

    # -- actions --------------------------------------------------------------
    subparsers.add_parser("actions", help="Open CI / pipeline runs")

    # -- wiki -----------------------------------------------------------------
    subparsers.add_parser("wiki", help="Open the project wiki")

    # -- milestones -----------------------------------------------------------
    subparsers.add_parser("milestones", help="Open milestone list")

    # -- settings -------------------------------------------------------------
    subparsers.add_parser("settings", help="Open repository settings")

    return parser


def resolve_url(args: Namespace, forge: GitForge) -> str:
    if args.command is None:
        return forge.home()

    elif args.command == "commit":
        return forge.commit(args.sha)

    elif args.command == "branch":
        if args.name:
            return forge.branch(args.name)
        return forge.branches()

    elif args.command == "tag":
        if args.name:
            return forge.tag(args.name)
        return forge.tags()

    elif args.command == "diff":
        if len(args.refs) == 1 and ".." in args.refs[0]:
            base, _, head = args.refs[0].partition("..")
            return forge.diff(base, head)
        elif len(args.refs) == 2:
            base, head = args.refs
            return forge.diff(base, head)
        else:
            raise SystemExit("error: diff requires 'base..head' or two ref arguments.")

    elif args.command == "file":
        ref = args.ref or git_current_branch() or git_head()
        return forge.file(args.path, ref, args.line)

    elif args.command == "pr":
        if args.number is not None:
            return forge.pull_request(args.number)
        return forge.pull_requests()

    elif args.command == "issue":
        if args.number is not None:
            return forge.issue(args.number)
        return forge.issues()

    elif args.command == "release":
        if args.tag:
            return forge.release(args.tag)
        return forge.releases()

    elif args.command == "actions":
        return forge.actions()

    elif args.command == "wiki":
        return forge.wiki()

    elif args.command == "milestones":
        return forge.milestones()

    elif args.command == "settings":
        return forge.settings()

    else:
        raise SystemExit(f"error: unknown command '{args.command}'.")


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------


def main(argv: list[str] | None = None) -> None:
    parser = build_parser()
    args = parser.parse_args(argv)

    remote_url = git_remote_url(args.remote)
    remote = parse_remote(remote_url)

    forge = resolve_forge(remote)
    url = resolve_url(args, forge)

    action = resolve_url_action(args)
    action.execute(url)


if __name__ == "__main__":
    import sys

    main(sys.argv[1:])
