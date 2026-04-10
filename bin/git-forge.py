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
    git forge branch [<name>]          # branch (default: current)
    git forge branches                 # branch list
    git forge diff <ref1> [<ref2>]     # diff between refs / branches
    git forge pr [<number>]            # specific pull request
    git forge prs                      # pull request list
    git forge issue [<number>]         # specific issue
    git forge issues                   # issue list
    git forge file <path> [--line <n>] # file, optionally at a line
    git forge release [<tag>]          # tagged release
    git forge releases                 # tagged release
    git forge tags                     # tag list
    git forge actions                  # CI / pipeline runs
    git forge wiki                     # project wiki
    git forge settings                 # repository settings
    git forge milestones               # milestone list

Supported forges: GitHub, GitLab, Bitbucket.
"""

from __future__ import annotations

from argparse import ArgumentParser, Namespace
from dataclasses import dataclass
from typing import Protocol
from urllib.parse import quote as url_quote

# ---------------------------------------------------------------------------
# Domain model
# ---------------------------------------------------------------------------


@dataclass(frozen=True)
class Remote:
    host: str
    owner: str
    repository: str

    @property
    def url(self):
        return f"https://{self.host}/{self.owner}/{self.repository}"


def parse_remote(url: str) -> Remote:
    import re

    for remote_pattern in (
        r"https://([^/]+)/([^/]+)/(.+?)(\.git)?$",
        r"git@([^:]+):([^/]+)/(.+?)(\.git)?$",
    ):
        if match := re.match(remote_pattern, url):
            return Remote(
                host=match.group(1),
                owner=match.group(2),
                repository=match.group(3),
            )

    raise SystemExit(f"error: unsupported remote URL: {url}")


# ---------------------------------------------------------------------------
# Forge protocol and implementations
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
    def diff(self, base: str, head: str) -> str: ...
    def file(self, path: str, line: int | None) -> str: ...
    def pull_request(self, number: int) -> str: ...
    def pull_requests(self) -> str: ...
    def issue(self, number: int) -> str: ...
    def issues(self) -> str: ...
    def release(self, tag: str) -> str: ...
    def releases(self) -> str: ...
    def tags(self) -> str: ...
    def actions(self) -> str: ...
    def wiki(self) -> str: ...
    def settings(self) -> str: ...
    def milestones(self) -> str: ...


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

    def diff(self, base: str, head: str) -> str:
        return f"{self.remote.url}/compare/{url_quote(base, safe='/@')}...{url_quote(head, safe='/@')}"

    def file(self, path: str, line: int | None) -> str:
        # Resolve current branch so the link doesn't use a detached HEAD SHA.
        branch = git_current_branch() or "HEAD"
        url = (
            f"{self.remote.url}/blob/{url_quote(branch, safe='/@')}/{path.lstrip('/')}"
        )
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

    def tags(self) -> str:
        return f"{self.remote.url}/tags"

    def actions(self) -> str:
        return f"{self.remote.url}/actions"

    def wiki(self) -> str:
        return f"{self.remote.url}/wiki"

    def settings(self) -> str:
        return f"{self.remote.url}/settings"

    def milestones(self) -> str:
        return f"{self.remote.url}/milestones"


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

    def diff(self, base: str, head: str) -> str:
        return f"{self.remote.url}/-/compare/{url_quote(base, safe='/@')}...{url_quote(head, safe='/@')}"

    def file(self, path: str, line: int | None) -> str:
        branch = git_current_branch() or "HEAD"
        url = f"{self.remote.url}/-/blob/{url_quote(branch, safe='/@')}/{path.lstrip('/')}"
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

    def tags(self) -> str:
        return f"{self.remote.url}/-/tags"

    def actions(self) -> str:
        return f"{self.remote.url}/-/pipelines"

    def wiki(self) -> str:
        return f"{self.remote.url}/-/wikis"

    def settings(self) -> str:
        return f"{self.remote.url}/-/edit"

    def milestones(self) -> str:
        return f"{self.remote.url}/-/milestones"


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

    def diff(self, base: str, head: str) -> str:
        return f"{self.remote.url}/branches/compare/{url_quote(head, safe='/@')}%0D{url_quote(base, safe='/@')}"

    def file(self, path: str, line: int | None) -> str:
        branch = git_current_branch() or "HEAD"
        url = f"{self.remote.url}/src/{url_quote(branch, safe='/@')}/{path.lstrip('/')}"
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

    def tags(self) -> str:
        return f"{self.remote.url}/src/?tags"

    def actions(self) -> str:
        return f"{self.remote.url}/pipelines"

    def wiki(self) -> str:
        return f"{self.remote.url}/wiki"

    def settings(self) -> str:
        return f"{self.remote.url}/admin"

    def milestones(self) -> str:
        return f"{self.remote.url}/issues?milestone"


# ---------------------------------------------------------------------------
# Forge registry
# ---------------------------------------------------------------------------


def resolve_forge(remote: Remote) -> GitForge:
    forges = {
        "github.com": "github",
        "gitlab.com": "gitlab",
        "bitbucket.org": "bitbucket",
    }

    forge = next(
        (forge for host, forge in forges.items() if host == remote.host),
        "github",
    )

    if forge == "github":
        return GithubForge(remote)
    elif forge == "gitlab":
        return GitlabForge(remote)
    elif forge == "bitbucket":
        return BitbucketForge(remote)
    else:
        raise SystemExit(f"error: unsupported forge: {forge}")


# ---------------------------------------------------------------------------
# Git helpers
# ---------------------------------------------------------------------------


def git(*args: str) -> str:
    """Run a git command and return stripped stdout, raising on failure."""
    import subprocess

    result = subprocess.run(
        ["git", *args],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr.strip() or f"git {' '.join(args)} failed")
    return result.stdout.strip()


def git_remote_url(remote: str) -> str:
    try:
        return git("remote", "get-url", remote)
    except RuntimeError:
        raise SystemExit(f"error: remote '{remote}' not found.")


def git_current_branch() -> str | None:
    try:
        return git("rev-parse", "--abbrev-ref", "HEAD")
    except RuntimeError:
        return None


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
    parser.add_argument(
        "--print",
        dest="print_only",
        action="store_true",
        help="Print the URL instead of opening it",
    )

    subparsers = parser.add_subparsers(dest="command")

    # -- commit ---------------------------------------------------------------
    parser_commit = subparsers.add_parser("commit", help="Open a specific commit")
    parser_commit.add_argument("sha", help="Commit SHA (full or abbreviated)")

    # -- branch ---------------------------------------------------------------
    subparsers.add_parser("branches", help="Open branch list")
    parser_branch = subparsers.add_parser(
        "branch",
        help="Open a branch (default: current)",
    )
    parser_branch.add_argument("name", nargs="?", help="Branch name")

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

    # -- pr -------------------------------------------------------------------
    subparsers.add_parser("prs", help="Open pull request list")
    parser_pr = subparsers.add_parser("pr", help="Open a pull request")
    parser_pr.add_argument("number", nargs="?", type=int, help="PR number")

    # -- issues ---------------------------------------------------------------
    subparsers.add_parser("issues", help="Open issue list")
    parser_issue = subparsers.add_parser("issue", help="Open an issue")
    parser_issue.add_argument("number", nargs="?", type=int, help="Issue number")

    # -- releases -------------------------------------------------------------
    subparsers.add_parser("releases", help="Open releases")
    parser_release = subparsers.add_parser("release", help="Open a specific release")
    parser_release.add_argument("tag", nargs="?", help="Release tag")

    # -- tags -----------------------------------------------------------------
    subparsers.add_parser("tags", help="Open the tag list")

    # -- actions --------------------------------------------------------------
    subparsers.add_parser("actions", help="Open CI / pipeline runs")

    # -- wiki -----------------------------------------------------------------
    subparsers.add_parser("wiki", help="Open the project wiki")

    # -- settings -------------------------------------------------------------
    subparsers.add_parser("settings", help="Open repository settings")

    # -- milestones -----------------------------------------------------------
    subparsers.add_parser("milestones", help="Open milestone list")

    return parser


def resolve_url(args: Namespace, forge: GitForge) -> str:
    if args.command is None:
        return forge.home()

    elif args.command == "commit":
        return forge.commit(args.sha)

    elif args.command == "branch":
        name = args.name or git_current_branch() or "HEAD"
        return forge.branch(name)

    elif args.command == "branches":
        return forge.branches()

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
        return forge.file(args.path, args.line)

    elif args.command == "pr":
        return forge.pull_request(args.number)

    elif args.command == "prs":
        return forge.pull_requests()

    elif args.command == "issue":
        return forge.issue(args.number)

    elif args.command == "issues":
        return forge.issues()

    elif args.command == "release":
        return forge.release(args.tag)

    elif args.command == "releases":
        return forge.releases()

    elif args.command == "tags":
        return forge.tags()

    elif args.command == "actions":
        return forge.actions()

    elif args.command == "wiki":
        return forge.wiki()

    elif args.command == "settings":
        return forge.settings()

    elif args.command == "milestones":
        return forge.milestones()

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

    if args.print_only:
        print(url)
    else:
        import webbrowser

        webbrowser.open(url)


if __name__ == "__main__":
    import sys

    main(sys.argv[1:])
