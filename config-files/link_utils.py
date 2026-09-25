from pathlib import Path


def link(dotfile: str, symlink: str):
    source = Path(__file__).resolve().parent / dotfile
    target = Path.home() / symlink

    if target.is_symlink():
        print(f"'{target.name}' is a symlink: removing")
        target.unlink()
    elif target.is_dir():
        backup = target.with_name(target.name + ".bk")
        if backup.exists() or backup.is_symlink():
            raise FileExistsError(
                f"Cannot link '{target}': backup '{backup}' already exists. "
                "Move or remove the backup, then retry."
            )
        print(f"'{target.name}' is a directory: moving it to '{backup.name}'")
        target.replace(backup)
    elif target.is_file():
        backup = target.with_name(target.name + ".bk")
        if backup.exists() or backup.is_symlink():
            raise FileExistsError(
                f"Cannot link '{target}': backup '{backup}' already exists. "
                "Move or remove the backup, then retry."
            )
        print(f"'{target.name}' is a file: making a backup as '{backup}'")
        target.replace(backup)

    target.parent.mkdir(parents=True, exist_ok=True)
    print(f"Creating link '{target}' to '{source}'")
    target.symlink_to(source, target_is_directory=source.is_dir())


def unlink(symlink: str, **kwargs):
    target = Path.home() / symlink

    if not target.is_symlink():
        print(f"'{target.name}' isn't a link: ignoring")
        return

    print(f"unlinking '{target.name}'")
    target.unlink()
    backup = target.with_name(target.name + ".bk")
    if backup.is_dir() and not backup.is_symlink():
        print(f"Restoring backup of '{target.name}'")
        backup.replace(target)
    elif backup.is_file():
        print(f"Restoring backup of '{target.name}'")
        backup.replace(target)
