#!/usr/bin/env bash

set -e

# Remove the created temporary directory
trap 'cleanup' ERR
trap 'cleanup' EXIT
cleanup() {
  cd
  if [ -n "$tmdir" ]; then
    rm -rf "$tmpdir"
  fi
}

# This is the path where all zig stuff will be placed
ZIG_DIR="$HOME/.local/share/zig_nightly"
ZIG_ARCH_OS="x86_64-linux"
# This file stores the sha256sum of the currently installed release
zig_sha_file="$ZIG_DIR/shasum"

zig_index_url="https://ziglang.org/download/index.json"

echo "Downloading Zig release index..."
index=$(curl --progress-bar "$zig_index_url")

tarball_info=$(jq ".\"master\".\"${ZIG_ARCH_OS}\"" <<< "$index")
tarball_url=$(jq -r '."tarball"' <<< "$tarball_info")
tarball_filename=$(basename "$tarball_url")
tarball_expected_sha=$(jq -r '."shasum"' <<< "$tarball_info")

if [ -f "$zig_sha_file" ] && [ "$(cat "$zig_sha_file")" = "$tarball_expected_sha" ]; then
  echo "Up to date"
  exit 0
fi

zig_extract_dir="$ZIG_DIR/extract"
mkdir -p "$zig_extract_dir"
tmpdir=$(mktemp -d)

cd "$tmpdir"
echo "Downloading Zig release tarball..."
curl -O --progress-bar "$tarball_url"

tarball_actual_sha=$(sha256sum "$tarball_filename" | cut -d' ' -f1)
if [ "$tarball_actual_sha" != "$tarball_expected_sha" ]; then
  >&2 echo "error: SHA mismatch"
  >&2 echo "expected SHA: $tarball_expected_sha"
  >&2 echo "  actual SHA: $tarball_actual_sha"
  exit 1
else
  echo "Extracting release tarball..."
  tar -xf "$tarball_filename" --checkpoint=.1000 && echo ""

  extracted_dir=$(basename "$tarball_filename" .tar.xz)
  echo "Copying extracted files..."
  rsync -r --delete --info=PROGRESS2 "$extracted_dir"/ "$zig_extract_dir"
  echo "$tarball_actual_sha" > "$zig_sha_file"
  echo "Latest nightly has been installed to: $zig_extract_dir"
fi
