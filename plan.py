#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Toon Verstraelen <Toon.Verstraelen@UGent.be>
# SPDX-License-Identifier: CC-BY-4.0
"""StepUp workflow to compile the slides and to render the hands-on tutorials.

See README.md for instructions on how to run it.
"""

import tomllib
from pathlib import Path
from urllib.parse import urlparse

from stepup.core.api import amend, call, render_jinja, static
from stepup.reprep.api import compile_typst

# Slides
# ------
# The UGentish packages are not on Typst Universe,
# so they are cloned into .typst-packages/ugentish/ (see README.md).
# Other packages, such as Animo, are downloaded by Typst from Universe.
static("slides/", ".typst-packages/ugentish/")
TYPST_ARGS = ["--package-path=.typst-packages/ugentish/typst/packages"]
compile_typst("slides/slides.typ", "build/slides.pdf", typst_args=TYPST_ARGS)
compile_typst("slides/slides.typ", "build/slides.html", typst_args=TYPST_ARGS)

# Hands-on tutorials
# ------------------
# All Markdown and SVG files in handson/.template/ are rendered
# into one output directory per installment defined in installments.toml.
# The outputs are committed to Git, so participants can read them on GitHub.
# GitHub blocks external resources in SVG files shown in Markdown,
# so rendered SVG files that link to a bitmap are made self-contained:
# text is converted to paths and the bitmap is embedded (see bakesvg.py).
# This requires Inkscape.
static("handson/.template/")
PATH_INSTALLMENTS = "handson/.template/installments.toml"
amend(inp=PATH_INSTALLMENTS)
with open(PATH_INSTALLMENTS, "rb") as fh:
    installments = tomllib.load(fh)

for name, installment in installments.items():
    url = installment["sandbox"]
    parsed = urlparse(url)
    owner, repo = parsed.path.strip("/").split("/")
    variables = {
        "audience": installment["audience"],
        "sandbox": {"url": url, "host": parsed.netloc, "owner": owner, "name": repo},
    }
    dir_out = f"handson/{name}/"
    for path_template in static("handson/.template/*.md"):
        render_jinja(path_template, variables, dir_out)
    paths_bitmap = static("handson/.template/*.webp")
    for path_template in static("handson/.template/*.svg"):
        if ".webp" not in Path(path_template).read_text():
            render_jinja(path_template, variables, dir_out)
            continue
        name_svg = Path(path_template).name
        path_rendered = f"build/handson/{name}/{name_svg}"
        render_jinja(path_template, variables, path_rendered)
        call(
            "./bakesvg.py",
            "run",
            inp=[path_rendered, *paths_bitmap],
            out=f"{dir_out}{name_svg}",
        )

# Markdown files with lists in the sandbox template
# -------------------------------------------------
static("writelists.py", "bakesvg.py")
call("./writelists.py", "run", out="sandbox/animals.md", kind="animal")
call("./writelists.py", "run", out="sandbox/foods.md", kind="food")
