#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Toon Verstraelen <Toon.Verstraelen@UGent.be>
# SPDX-License-Identifier: CC-BY-4.0
"""Make an SVG file self-contained, so that it renders correctly on GitHub.

GitHub shows SVG files in Markdown through an ``<img>`` tag,
for which browsers block external resources: linked bitmaps and fonts are not loaded.
This script therefore (1) converts all text to paths with Inkscape
and (2) embeds all linked bitmaps as base64 data URIs.
Inkscape cannot do the second step for WebP images.
"""

import base64
import mimetypes
import re
import shutil
import subprocess
import tempfile
from pathlib import Path

from stepup.core.call import driver

RE_HREF = re.compile(r'(?P<attr>(?:xlink:)?href)="(?P<path>[^"#][^":]*)"')


def run(inp: list[str], out: list[str]):
    """Convert text to paths and embed bitmaps.

    Parameters
    ----------
    inp
        The first file is the SVG. All following files are the bitmaps it links to,
        which are matched by their file name.
    out
        The self-contained SVG.
    """
    path_svg, *paths_bitmap = map(Path, inp)
    bitmaps = {path.name: path for path in paths_bitmap}
    with tempfile.TemporaryDirectory() as dir_tmp:
        # Inkscape resolves links relative to the SVG file, so work in a directory with copies.
        path_in = Path(dir_tmp) / "in.svg"
        path_tmp = Path(dir_tmp) / "tmp.svg"
        shutil.copy(path_svg, path_in)
        for name, path in bitmaps.items():
            shutil.copy(path, Path(dir_tmp) / name)
        subprocess.run(
            [
                "inkscape",
                path_in,
                "--export-type=svg",
                "--export-plain-svg",
                "--export-text-to-path",
                f"--export-filename={path_tmp}",
            ],
            check=True,
        )
        text = path_tmp.read_text()
    Path(out[0]).write_text(RE_HREF.sub(lambda m: embed(m, bitmaps), text))


def embed(match: re.Match, bitmaps: dict[str, Path]) -> str:
    """Replace a link to a bitmap by a data URI."""
    path = bitmaps.get(Path(match["path"]).name)
    if path is None:
        raise ValueError(f"Linked file not listed as input: {match['path']}")
    mime = mimetypes.guess_type(path)[0]
    if mime is None:
        raise ValueError(f"Cannot determine the media type of {path}")
    data = base64.b64encode(path.read_bytes()).decode()
    return f'{match["attr"]}="data:{mime};base64,{data}"'


if __name__ == "__main__":
    driver()
