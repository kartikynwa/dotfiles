from pathlib import Path
import argparse
import shutil
import sys
from slugify import slugify
import os

import epub_meta

fiction_keywords = ("f", "fiction")
nonfiction_keywords = ("nf", "nonfiction")
textbook_keywords = ("t", "textbook")


def main():
    home = Path.home()
    docsdir = home / "docs"
    librarydir = docsdir / "library"
    bookdir = librarydir / "books"

    parser = argparse.ArgumentParser(description="Move and rename ePub files")
    parser.add_argument("epub_file", type=str, help="Location of ePub file")
    parser.add_argument(
        "-t",
        "--type",
        type=str,
        help="Specify genre",
        default=nonfiction_keywords[0],
        choices=(fiction_keywords + nonfiction_keywords + textbook_keywords),
    )
    parser.add_argument(
        "-m",
        "--move",
        action="store_true",
        help="Move the ePub file to the new location (by default only the new filename is printed)",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Overwrite the target file if it already exists. Useless without -m/--move.",
    )

    args = parser.parse_args()

    if args.type in fiction_keywords:
        bookdir = bookdir / "fikshun"
    elif args.type in nonfiction_keywords:
        bookdir = bookdir / "non_fikshun"
    else:
        bookdir = bookdir / "textbooks"

    try:
        metadata = epub_meta.get_epub_metadata(args.epub_file)
    except Exception:
        sys.stderr.write("Could not open file.\n")
        sys.exit(1)

    title = metadata.get("title")
    authors = metadata.get("authors", [])
    if not title:
        sys.stderr.write("ePub file has no title. What is this nonsense.\n")
        sys.exit(1)

    title = slugify(title, separator="_")
    authors = [slugify(a, separator="_") for a in authors]
    authors = "-".join(authors)
    filename = title
    if authors:
        filename += f"-{authors}"
    filename += ".epub"

    print(filename)
    if not args.move:
        sys.exit(0)

    new_path = bookdir / filename
    exists = os.path.exists(new_path)
    if exists and not args.force:
        sys.stderr.write("Destination file already exists. Not moving.\n")
        sys.exit(1)
    elif exists and args.force:
        print("Destination file already exists. Overwriting.")
    shutil.move(args.epub_file, new_path)
    print("File moved :)")


if __name__ == "__main__":
    main()
