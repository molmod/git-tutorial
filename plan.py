#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2026 Toon Verstraelen <Toon.Verstraelen@UGent.be>
# SPDX-License-Identifier: CC-BY-4.0
"""StepUp workflow to compile the slides and to render the hands-on tutorials.

See README.md for instructions on how to run it.
"""

import tomllib
from urllib.parse import urlparse

from stepup.core.api import amend, call, copy, render_jinja, static
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
# All files in handson/.template/ are rendered (Markdown and SVG) or copied (PNG)
# into one output directory per installment defined in installments.toml.
# The outputs are committed to Git, so participants can read them on GitHub.
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
    for path_template in static("handson/.template/*.md", "handson/.template/*.svg"):
        render_jinja(path_template, variables, dir_out)
    for path_image in static("handson/.template/*.png"):
        copy(path_image, dir_out)

# Markdown files with lists in the sandbox template
# -------------------------------------------------
static("writelists.py")
call("./writelists.py", "run", out="sandbox/animals.md", kind="animal")
call("./writelists.py", "run", out="sandbox/foods.md", kind="food")
