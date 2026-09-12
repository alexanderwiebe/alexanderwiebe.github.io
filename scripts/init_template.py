#!/usr/bin/env python3
"""Initialize a new repo created from the base-notebook template.

Replaces 'base-notebook' references with the new project name and
registers base-notebook as the 'template' git remote so you can pull
future updates with 'git fetch template'.
"""

import re
import subprocess
from pathlib import Path

TEMPLATE_FILES = [
    "pyproject.toml",
    "README.md",
    "_quarto.yml",
    ".devcontainer/devcontainer.json",
]

TEMPLATE_RC = ".templaterc"


def detect_project_name() -> str:
    """Derive project name from git remote origin URL, fallback to cwd."""
    try:
        url = subprocess.check_output(
            ["git", "remote", "get-url", "origin"],
            stderr=subprocess.DEVNULL,
            text=True,
        ).strip()
        # Extract repo name from URL (handles https and ssh forms)
        name = re.split(r"[/:]", url)[-1]
        return name.removesuffix(".git")
    except subprocess.CalledProcessError:
        return Path.cwd().name


def to_title(slug: str) -> str:
    return slug.replace("-", " ").replace("_", " ").title()


def to_snake(slug: str) -> str:
    return slug.replace("-", "_")


def replace_in_file(path: Path, slug: str, title: str, snake: str) -> bool:
    """Replace base-notebook variants in a file. Returns True if changed."""
    assert path.exists(), f"Expected file {path} to exist"
    original = path.read_text()
    updated = (
        original.replace("Base Notebook", title)
        .replace("base-notebook", slug)
        .replace("base_notebook", snake)
    )
    if updated == original:
        return False
    path.write_text(updated)
    return True


def add_template_remote(rc_path: Path) -> None:
    """Register base-notebook as the 'template' git remote."""
    assert rc_path.exists(), f"Expected {rc_path} to exist"
    template_url = rc_path.read_text().strip()

    existing = subprocess.run(
        ["git", "remote", "get-url", "template"],
        capture_output=True,
        text=True,
    )
    if existing.returncode == 0:
        print(f"  remote 'template' already set to {existing.stdout.strip()}")
        return

    subprocess.run(["git", "remote", "add", "template", template_url], check=True)
    print(f"  added remote 'template' -> {template_url}")


def main() -> None:
    root = Path(__file__).parent.parent
    slug = detect_project_name()

    if slug == "base-notebook":
        print("Project name is still 'base-notebook' — nothing to rename.")
        print("Make sure 'origin' remote points to your new repo before running init.")
        return

    title = to_title(slug)
    snake = to_snake(slug)

    print(f"Initializing project: {title} (slug={slug}, pkg={snake})\n")

    print("Renaming references:")
    for rel in TEMPLATE_FILES:
        path = root / rel
        if not path.exists():
            print(f"  skip (not found): {rel}")
            continue
        changed = replace_in_file(path, slug, title, snake)
        status = "updated" if changed else "no changes"
        print(f"  {rel}: {status}")

    print("\nConfiguring git remotes:")
    add_template_remote(root / TEMPLATE_RC)

    print(
        "\nDone. Review the changes above, then commit:\n"
        "  git add -p && git commit -m 'chore: initialize from base-notebook template'"
    )


if __name__ == "__main__":
    main()
