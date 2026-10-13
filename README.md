<!--
SPDX-FileCopyrightText: © 2026 Toon Verstraelen <Toon.Verstraelen@UGent.be>
SPDX-License-Identifier: CC-BY-4.0
-->

![License](https://img.shields.io/github/license/molmod/git-tutorial)
[![Publish Slides](https://github.com/molmod/git-tutorial/actions/workflows/publish.yaml/badge.svg)](https://github.com/molmod/git-tutorial/actions/workflows/publish.yaml)

# CMM Git(Hub) tutorial

## Overview

This repository contains the source materials for the CMM Git(Hub) tutorial.

1. Start with the tutorial slides, which are available in the [Releases](https://github.com/molmod/git-tutorial/releases) section of this repository.
   (These will be presented during the live tutorial session.)
1. Then get a basic understanding of GitHub's features by following [`handson_web.md`](handson_web.md).
1. Finally, dive into the command-line usage of Git with the hands-on tutorial in [`handson_cli.md`](handson_cli.md).

## Compiling the slides

The slides are written in [Typst](https://typst.app/) (version 0.15 or newer)
with the following packages:

- [Animo](https://github.com/reproducible-reporting/animo) (`@preview/animo:0.2.0`) for animated slides.
- [UGentish](https://github.com/reproducible-reporting/ugentish) (`@ugentish/animo-ugentish`, `@ugentish/ugentish`)
  for the look and feel.
  This is an unofficial style, loosely based on the UGent style guide.

Neither package is available through Typst Universe (yet),
so you have to make them available to Typst by hand.
The following commands clone them into the git-ignored `.typst-packages/` directory of this repository,
in the directory layout that Typst expects:

```bash
mkdir -p .typst-packages/preview/animo
git clone --depth 1 --branch v0.2.0 \
  https://github.com/reproducible-reporting/animo.git \
  .typst-packages/preview/animo/0.2.0
git clone --depth 1 \
  https://github.com/reproducible-reporting/ugentish.git \
  .typst-packages/ugentish-repo
ln -s ugentish-repo/typst/packages/ugentish .typst-packages/ugentish
```

Then tell Typst where to find them and compile the slides:

```bash
export TYPST_PACKAGE_PATH="${PWD}/.typst-packages"
typst compile slides/slides.typ slides.pdf
typst compile --format html --features html slides/slides.typ slides.html
```

Notes:

- `TYPST_PACKAGE_PATH` replaces Typst's default directory for local packages (`@local`).
  Packages from `@preview`, such as CeTZ, which Animo UGentish uses, are still downloaded automatically.
- Editors and IDEs only see this variable when they are started from an environment in which it is set.
  For example, to preview the slides with Tinymist in VS Code,
  start VS Code from a shell in which `TYPST_PACKAGE_PATH` is set.
- Compiling requires the fonts Source Sans 3, Source Code Pro and Erewhon Math,
  which can be downloaded from the sites listed in the
  [UGentish README](https://github.com/reproducible-reporting/ugentish#fonts).
  The workflow in [`.github/workflows/publish.yaml`](.github/workflows/publish.yaml)
  performs the same steps as above, including the font installation, on a clean Ubuntu machine.

## License

Unless noted otherwise, the contents of this repository are licensed under the
[Creative Commons Attribution 4.0 International License (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/) license.

SPDX License and copyright specifiers are included in header comments of all text files,
except for the SVG and PNG files, for which this information can be found in the [`REUSE.toml`](REUSE.toml) file,
as per the [REUSE Specification](https://reuse.software/spec/).
