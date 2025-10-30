#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "epub-meta",
#     "python-slugify",
# ]
# ///

import argparse
import sys

from slugify import slugify
import epub_meta


def main():
    parser = argparse.ArgumentParser(description="Move and rename ePub files")
    parser.add_argument("epub_file", type=str, help="Location of ePub file")

    args = parser.parse_args()

    try:
        metadata = epub_meta.get_epub_metadata(args.epub_file)
    except Exception:
        sys.stderr.write("Could not open file.\n")
        sys.exit(1)

    title = metadata.get("title")
    authors = metadata.get("authors", [])
    if not title:
        sys.stderr.write("ePub file has no title. What is this nonsense?\n")
        sys.exit(1)

    title = slugify(title, separator="_")
    authors = [slugify(a, separator="_") for a in authors]
    authors = "-".join(authors)
    filename = title
    if authors:
        filename += f"-{authors}"
    filename += ".epub"

    print(filename)


if __name__ == "__main__":
    main()
