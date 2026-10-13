// SPDX-FileCopyrightText: © 2026 Toon Verstraelen <Toon.Verstraelen@UGent.be>
// SPDX-License-Identifier: CC-BY-4.0

// The packages used here are not (yet) on Typst Universe.
// See the README for how to make them available to Typst.
#import "@ugentish/animo-ugentish:0.1.0": *

#show: animo-ugentish.with(
  short: "git",
  sections: (
    basics: "Basic concepts",
    handson: "Hands-on",
  ),
  logos: {
    box(image("logo-ugent.svg"))
    h(0.75cm)
    box(image("logo-cmm.svg"))
  },
)

#title-slide(
  "Getting Started with Git(Hub)",
  authors: "Toon Verstraelen",
  note: datetime(year: 2026, month: 5, day: 8).display("[day padding:none] [month repr:long] [year]"),
)

#outline-slide("basics")

#slide(title: [Git = A _distributed_ version control system])[
  - *Why?* Collaborative development

  - *What?* Shared history of a tree of files

  - *How?*
    - Software
    - Database format
    - Network protocols
]

#slide(title: "Why care?")[
  *Widely applied* in research & education to ...

  - Develop simulation software
  - Write courses, articles, theses, presentations, etc.
  - Manage research data

  *Enables*

  - Collaboration
  - Incremental development
  - Provenance
  - Attribution
  - Backup
]

#slide(title: [Anatomy of a _local_ Git "repo(sitory)"])[
  #grid(
    columns: 2,
    align: top,
    gutter: 2cm,
    [
      *Example:* \
      molmod/sandbox
      #par(leading: 8pt, text(font: fonts.mono, size: 18pt)[
        . \
        ├── .git/ \
        │   ├── config \
        │   ├── HEAD \
        │   ├── #text(weight: "bold", fill: ugt.red)[objects/] \
        │   ├── refs/ \
        │   └── ... \
        ├── #text(fill: ugt.green)[.editorconfig] \
        ├── #text(fill: ugt.green)[.gitignore] \
        ├── #text(fill: ugt.green)[.pre-commit-config.yaml] \
        ├── #text(fill: ugt.green)[README.md] \
        ├── #text(fill: ugt.green)[add_comments.py] \
        ├── #text(fill: ugt.green)[participants.md] \
        └── ... \
      ])
    ],
    [
      *Three* locations of your files:
      #text(size: 20pt, table(
        columns: 3,
        inset: 0.5em,
        table.header(
          text(weight: "bold", fill: ugt.green)[Working directory],
          [#text(weight: "bold", fill: ugt.red)[Staging area] (or index)],
          text(weight: "bold", fill: ugt.red)[Git repository],
        ),
        [Files being edited],
        [Version of files to be added to history],
        [Database with all previous versions of the working directory],
      ))
    ],
  )
]

#slide(title: [Git repository = directed acyclic graph of "commits"])[
  #align(center, image("git_repository_1.svg"))

  *Each version (called "commit") ...*

  - ... has a hexadecimal "hash"
  - ... holds metadata (author, timestamp, parents, children, ...)
  - ... represents a full snapshot of the working tree at that time
]

#slide(title: "Git branches refer to commits")[
  #align(center, image("git_repository_2.svg"))

  - Examples: `alice`, `bob`, `main`, ... + preceding commits
  - `main` = _default_ branch
  - `alice` and `bob` temporarily _diverge_, to be _merged_ later.
]

#slide(title: "Creating new commits")[
  #align(center, image("git_repository_3.svg"))

  - Modify files in the _working directory_.
  - Add modified files to the _staging area_.
  - "Commit" the staged files $=>$ New commit after current *HEAD*.
]

#slide(title: "Git in the terminal = most complete interface")[
  Minimal example:

  ```bash
  # Add an extra line to the README.md
  echo "Thank you for reading!" >> README.md

  # Add the modified file to the staging area
  git add README.md

  # Create a new commit
  git commit -m "Make README more friendly."
  ```

  Git has many subcommands (> 100).
  You only need a handful frequently.
]

#slide(title: "Distributed?")[
  #grid(
    columns: (1fr, 1.5fr),
    gutter: 1cm,
    [
      Git facilitates *online collaboration*:

      - Repositories can be "cloned"

      - Branches can be "pushed" and "pulled"

      *Scaling!* E.g. Linux has 13500 contributors.
    ],
    image("distributed.svg", width: 100%),
  )
]

#slide(title: [Git $!=$ GitHub])[
  #grid(
    columns: (2.1fr, 3fr),
    align: top,
    gutter: 1cm,
    [
      *Git* #box(inset: (left: 0.2em, bottom: -0.2em), image("logo-git.svg", width: 1cm))

      - Distributed version control system
      - Open source
      - https://git-scm.com/
      - Created in 2005 to maintain the Linux source
    ],
    [
      *GitHub* #box(inset: (left: 0.2em, bottom: -0.2em), image("logo-github.svg", width: 1cm))

      - Collaboration platform built on top of Git
      - Commercial product
      - Public = https://github.com
      - Internal = https://github.ugent.be
      - Company founded in 2007
      - Bought by Microsoft in 2018
    ],
  )
]

#slide(title: "github.ugent.be")[
  *For internal use only:*

  - Only accessible with UGent account
  - Data remains on-premises
  - Research or education (not administration)

  *Basic GitHub features:*

  - Visualization of a Git repository
  - Simple file edits
  - Issue tracker
  - Pull requests
  - Management (permissions, teams, ...)
]

#slide(title: "github.com")[
  Anyone can create an account

  *Goes beyond basic GitHub features:*

  - Continuous integration, a.k.a. "Actions"
  - Copilot + VSCode integration
  - GitHub Pages
  - Public profile
  - ...
]

#slide(title: "Data management aspects")[
  *License:*

  - Define it at the very start (first commit).
  - Bare minimum: `LICENSE` file + mention in `README.md`.
  - Tutorial repo applies #link("https://reuse.software")[REUSE] recommendations.

  *Suggest citations for a Git Repo:*

  - Use `CITATION.cff` file (https://citation-file-format.github.io/)

  *GitHub $!=$ Zenodo*

  - GitHub: live data
  - Zenodo: read-only deposits
]

#slide(title: "Quality Assurance")[
  Recommended from *Day 1*:

  - Use a `.gitignore` file to avoid committing unnecessary files.
  - Use a `.editorconfig` file to ensure consistent formatting.
  - Use a `.pre-commit-config.yaml` file to automatically check code quality before committing. See https://pre-commit.com/ for more details.

  Later, you can also consider:

  - Continuous integration (e.g. #link("https://docs.github.com/en/actions")[GitHub Actions]) to automatically run tests on new commits.
]

#outline-slide("handson")

#slide(title: "Links")[
  https://github.com/molmod/git-tutorial

  - This presentation
  - Two step-by-step guides:
    + Basic GitHub usage
    + Terminal Git usage

  https://github.com/molmod/sandbox

  Private repository for experimentation.

  (You should all have read access. Accept the invitation if you haven't already.)
]
