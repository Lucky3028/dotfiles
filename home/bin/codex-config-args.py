"""Apply shared Codex defaults as command-line overrides."""

from __future__ import annotations

import datetime
import json
import os
import sys
from pathlib import Path

try:
    import tomllib
except ModuleNotFoundError:
    try:
        import tomli as tomllib
    except ModuleNotFoundError as error:
        raise SystemExit(
            "Codex shared settings need Python 3.11+ or the 'tomli' package."
        ) from error


def is_bare_toml_key(key: str) -> bool:
    return bool(key) and all(
        character.isascii() and (character.isalnum() or character in "_-")
        for character in key
    )


def toml_key(key: str) -> str:
    if is_bare_toml_key(key):
        return key
    return json.dumps(key, ensure_ascii=False)


def toml_value(value: object) -> str:
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, str):
        return json.dumps(value, ensure_ascii=False)
    if isinstance(value, (int, float)):
        return repr(value)
    if isinstance(value, list):
        return "[" + ", ".join(toml_value(item) for item in value) + "]"
    if isinstance(value, dict):
        entries = ", ".join(
            f"{toml_key(key)} = {toml_value(item)}" for key, item in value.items()
        )
        return "{" + entries + "}"
    if isinstance(value, (datetime.date, datetime.datetime, datetime.time)):
        return value.isoformat()
    raise TypeError(f"Unsupported TOML value: {type(value).__name__}")


def current_user_runtime_dir() -> str | None:
    if sys.platform != "linux":
        return None

    uid = os.getuid()
    runtime_dir = Path(f"/run/user/{uid}")
    if os.environ.get("XDG_RUNTIME_DIR") is None:
        return None
    if Path(os.environ["XDG_RUNTIME_DIR"]) != runtime_dir:
        return None

    try:
        metadata = runtime_dir.stat()
    except OSError:
        return None

    if metadata.st_uid != uid or metadata.st_mode & 0o077:
        return None
    return str(runtime_dir)


def add_current_user_runtime_permission(config: dict[str, object]) -> None:
    runtime_dir = current_user_runtime_dir()
    if runtime_dir is None:
        return

    profile_name = config.get("default_permissions")
    permissions = config.get("permissions")
    if not isinstance(profile_name, str) or not isinstance(permissions, dict):
        return

    profile = permissions.get(profile_name)
    if not isinstance(profile, dict):
        return

    filesystem = profile.get("filesystem")
    if isinstance(filesystem, dict):
        filesystem[runtime_dir] = "write"


def is_runtime_setting(path: tuple[str, ...]) -> bool:
    return (
        path[0] in {"profile", "profiles", "projects"}
        or path == ("tui", "screen_reader_detection_done")
        or path[:2] == ("tui", "model_availability_nux")
    )


def flatten_config(
    value: object, path: tuple[str, ...] = ()
) -> list[tuple[tuple[str, ...], object]]:
    if path and is_runtime_setting(path):
        return []
    if isinstance(value, dict):
        if path and any(not is_bare_toml_key(key) for key in value):
            return [(path, value)]
        leaves: list[tuple[tuple[str, ...], object]] = []
        for key, child in value.items():
            leaves.extend(flatten_config(child, (*path, key)))
        return leaves
    return [(path, value)]


def main() -> None:
    if len(sys.argv) < 3:
        raise SystemExit(
            "Usage: codex-config-args.py CODEX_BIN SHARED_CONFIG [CODEX_ARGS...]"
        )

    codex_bin = sys.argv[1]
    config_path = Path(sys.argv[2])
    codex_args = sys.argv[3:]

    with config_path.open("rb") as shared_config:
        config = tomllib.load(shared_config)
    add_current_user_runtime_permission(config)

    overrides: list[str] = []
    for path, value in flatten_config(config):
        if not path:
            continue
        key = ".".join(toml_key(part) for part in path)
        overrides.extend(("--config", f"{key}={toml_value(value)}"))

    os.execvpe(codex_bin, [codex_bin, *overrides, *codex_args], os.environ)


if __name__ == "__main__":
    main()
