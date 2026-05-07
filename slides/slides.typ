// SPDX-FileCopyrightText: © 2026 Toon Verstraelen <Toon.Verstraelen@UGent.be>
// SPDX-License-Identifier: CC-BY-4.0

#import "ugentish.typ": *

#show: ugentish-theme.with(
  title: "Getting Started with Git(Hub)",
  author: "Toon Verstraelen",
  date: datetime(year: 2026, month: 5, day: 8),
)

#title-slide()

== Git = A _distributed_ version control system

- *Why?* Collaborative development

- *What?* Shared history of a tree of files

- *How?*
  - Software
  - Database format
  - Network protocols

== Why care?

*Widely applied* in research & education to ...

- Develop simulation software
- Write courses, articles, theses, presentations, ... (LaTeX or Typst)
- Manage research data

*Enables*

- Collaboration
- Incremental development
- Provenance
- Attribution
- Backup

== Anatomy of a _local_ Git "repo(sitory)"

#grid(
  columns: 2,
  align: top,
  gutter: 2cm,
  [
    *Example:* \
    molmod/sandbox
    #par(leading: 8pt, text(font: "Inconsolata", size: 12pt)[
    . \
    ├── .git/ \
    │   ├── config \
    │   ├── HEAD \
    │   ├── #text(weight: "bold", fill: ug.red)[objects/] \
    │   ├── refs/ \
    │   └── ... \
    ├── #text(fill: ug.green)[.editorconfig] \
    ├── #text(fill: ug.green)[.gitignore] \
    ├── #text(fill: ug.green)[.pre-commit-config.yaml] \
    ├── #text(fill: ug.green)[README.md] \
    ├── #text(fill: ug.green)[add_comments.py] \
    ├── #text(fill: ug.green)[participants.md] \
    └── ... \
    ])
  ],
  [
    *Three* locations of your files:
    #text(size: 20pt, table(
      columns: 3,
      inset: 0.5em,
      table.header(
        text(weight: "bold", fill: ug.green)[Working directory],
        [#text(weight: "bold", fill: ug.red)[Staging area] (or index)],
        text(weight: "bold", fill: ug.red)[Git repository],
      ),
      [Files being edited],
      [Version of files to be added to history],
      [Database with all previous versions of the working directory]
    ))
  ]
)

== Git repository = directed graph of "commits"

#align(center, image("git_repository_1.svg"))

*Each version (called "commit") ...*

- ... has a hexadecimal "hash"
- ... holds metadata (author, timestamp, parents, children, ...)
- ... contains a full copy of all files in working tree at that time

== Git branches refer to commits

#align(center, image("git_repository_2.svg"))

- Examples: `alice`, `bob`, `main`, ... + preceding commits
- `main` = _default_ branch
- `alice` and `bob` temporarily _diverge_, to be _merged_ later.

== Creating new commits

#align(center, image("git_repository_3.svg"))

- Modify files in the _working directory_.
- Add modified files to the _staging area_.
- "Commit" the staged files $=>$ New commit after current *HEAD*.

== Git in the terminal = most powerful

Minimal example:

```bash
# Add an extra line to the README.md
echo "Thank you for reading!" >> README.md

# Add the modified file to the staging area
git add README.md

# Create a new commit
git commit -m "Make README more friendly."
```

There are $approx$ 260 `git` sub-commands. (I use $approx$ 25 of them.)

== Distributed?

#grid(
  columns: (1fr, 1.5fr),
  gutter: 1cm,
  [
    Git facilitates *online collaboration*:

    - Repositories can be "cloned"

    - Branches can be "pushed" and "pulled"

    *Scaling!* E.g. Linux has 13500 contributors.
  ],
  image("distributed.svg", width: 100%)
)

== Git $!=$ GitHub

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
    *GitHub*
 #box(inset: (left: 0.2em, bottom: -0.2em), image("logo-github.svg", width: 1cm))

    - Web interface to Git
    - Commercial product
    - Public = https://github.com
    - Internal = https://github.ugent.be
    - Company founded in 2007
    - Bought by Microsoft in 2018
  ]
)

== GitHub: key features

*UGent GitHub has:*

- Visualization of a Git repository
- Simple file edits (not recommended)
- Issue tracker
- Pull requests
- Management features (permissions)

*Public GitHub has more:*

- Continuous integration, a.k.a. "Actions"
- Copilot
- ...
