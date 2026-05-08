// SPDX-FileCopyrightText: © 2026 Toon Verstraelen <Toon.Verstraelen@UGent.be>
// SPDX-License-Identifier: CC-BY-4.0

#import "ugentish.typ": *

#show: ugentish-theme.with(
  title: "Getting Started with Git(Hub)",
  author: "Toon Verstraelen",
  date: datetime(year: 2026, month: 5, day: 8),
)

#title-slide()

= Basic concepts

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
- Write courses, articles, theses, presentations, etc.
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

== Git repository = directed acyclic graph of "commits"

#align(center, image("git_repository_1.svg"))

*Each version (called "commit") ...*

- ... has a hexadecimal "hash"
- ... holds metadata (author, timestamp, parents, children, ...)
- ... represents a full snapshot of the working tree at that time

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

== Git in the terminal = most complete interface

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

    - Collaboration platform built on top of Git
    - Commercial product
    - Public = https://github.com
    - Internal = https://github.ugent.be
    - Company founded in 2007
    - Bought by Microsoft in 2018
  ]
)

== github.ugent.be

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

== github.com

Anyone can create an account

*Goes beyond basic GitHub features:*

- Continuous integration, a.k.a. "Actions"
- Copilot + VSCode integration
- GitHub Pages
- Public profile
- ...

== Data management aspects

*License:*

- Define it at the very start (first commit).
- Bare minimum: `LICENSE` file + mention in `README.md`.
- Tutorial repo applies #link("https://reuse.software")[REUSE] recommendations.

*Suggest citations for a Git Repo:*

- Use `CITATION.cff` file (https://citation-file-format.github.io/)

*GitHub $!=$ Zenodo*

- GitHub: live data
- Zenodo: read-only deposits

== Quality Assurance

Recommended from *Day 1*:

- Use a `.gitignore` file to avoid committing unnecessary files.
- Use a `.editorconfig` file to ensure consistent formatting.
- Use a `.pre-commit-config.yaml` file to automatically check code quality before committing. See https://pre-commit.com/ for more details.

Later, you can also consider:

- Continuous integration (e.g. #link("https://docs.github.com/en/actions")[GitHub Actions]) to automatically run tests on new commits.

= Hands-on

== Links

https://github.com/molmod/git-tutorial

- This presentation
- Two step-by-step guides:
  + Basic GitHub usage
  + Terminal Git usage

https://github.com/molmod/sandbox

  Private repository for experimentation.

  (You should all have read access. Accept the invitation if you haven't already.)
