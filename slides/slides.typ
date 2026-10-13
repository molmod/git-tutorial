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

#slide(
  title: [Git = A _distributed_ version control system],
  animation: {
    import anim: *
    sub(reveal("what"))
    sub(reveal("how"))
  },
)[
  - *Why?* Collaborative development

  #tag("what")[
    - *What?* Shared history of a tree of files
  ]

  #tag("how")[
    - *How?*
      - Software
      - Database format
      - Network protocols
  ]
]

#slide(title: "Why care?", animation: anim.sub(anim.reveal("enables")))[
  *Widely applied* in research & education to ...

  - Develop simulation software
  - Write courses, articles, theses, presentations, etc.
  - Manage research data

  #tag("enables")[
    *Enables*

    - Collaboration
    - Incremental development
    - Provenance
    - Attribution
    - Backup
  ]
]

#slide(
  title: [Anatomy of a _local_ Git "repo(sitory)"],
  animation: {
    import anim: *
    sub(
      reveal("working"),
      apply("tree-working", text.with(fill: ugc.green)),
    )
    sub(
      reveal("staging"),
      apply("tree-git", text.with(weight: "bold", fill: ugc.red)),
    )
    sub(reveal("repository"))
  },
)[
  #grid(
    columns: 2,
    align: top,
    gutter: 2cm,
    [
      *Example:* \
      `tovrstra/sandbox`
      #par(leading: 8pt, text(font: "Source Code Pro", size: 18pt, fill: luma(65%))[
        . \
        ├── .git/ \
        │   ├── config \
        │   ├── HEAD \
        │   ├── #tag("tree-git")[objects/] \
        │   ├── refs/ \
        │   └── ... \
        ├── #tag("tree-working")[.editorconfig] \
        ├── #tag("tree-working")[.gitignore] \
        ├── #tag("tree-working")[.pre-commit-config.yaml] \
        ├── #tag("tree-working")[README.md] \
        ├── #tag("tree-working")[add_comments.py] \
        ├── #tag("tree-working")[participants.md] \
        └── ... \
      ])
    ],
    [
      *Three* locations of your files:
      #table(
        columns: 3,
        inset: 0.5em,
        table.header(
          tag("working", text(weight: "bold", fill: ugc.green)[Working directory]),
          tag("staging", [#text(weight: "bold", fill: ugc.red)[Staging area] (or index)]),
          tag("repository", text(weight: "bold", fill: ugc.red)[Git repository]),
        ),
        tag("working")[Files being edited],
        tag("staging")[Version of files to be added to history],
        tag("repository")[Database with all previous versions of the working directory],
      )
    ],
  )
]

#slide(
  title: [Git repository = directed acyclic graph of "commits"],
  animation: anim.sub(anim.reveal("commit")),
)[
  #align(center, image("git_repository_1.svg"))

  #tag("commit")[
    *Each version (called "commit") ...*

    - ... has a hexadecimal "hash"
    - ... holds metadata (author, timestamp, parents, children, ...)
    - ... represents a full snapshot of the working tree at that time
  ]
]

#slide(title: "Git branches refer to commits", animation: anim.sub(anim.reveal("branches")))[
  #align(center, image("git_repository_2.svg"))

  #tag("branches")[
    - Examples: `alice`, `bob`, `main`, ... + preceding commits
    - `main` = _default_ branch
    - `alice` and `bob` temporarily _diverge_, to be _merged_ later.
  ]
]

#slide(title: "Creating new commits", animation: anim.sub(anim.reveal("steps")))[
  #align(center, image("git_repository_3.svg"))

  #tag("steps")[
    - Modify files in the _working directory_.
    - Add modified files to the _staging area_.
    - "Commit" the staged files $=>$ New commit after current *HEAD*.
  ]
]

#slide(
  title: "Git in the terminal = most complete interface",
  animation: {
    import anim: *
    sub(reveal("example"))
    sub(reveal("subcommands"))
  },
)[
  Minimal example:

  #tag("example")[
    ```bash
    # Add an extra line to the README.md
    echo "Thank you for reading!" >> README.md

    # Add the modified file to the staging area
    git add README.md

    # Create a new commit
    git commit -m "Make README more friendly."
    ```
  ]

  #tag("subcommands")[
    Git has many subcommands (> 100).
    You only need a handful frequently.
  ]
]

#slide(title: "Distributed?", animation: anim.sub(anim.reveal("scaling")))[
  #grid(
    columns: (1fr, 1.5fr),
    gutter: 1cm,
    [
      Git facilitates *online collaboration*:

      - Repositories can be "cloned"

      - Branches can be "pushed" and "pulled"

      #tag("scaling")[*Scaling!* E.g. Linux has 13500 contributors.]
    ],
    image("distributed.svg", width: 100%),
  )
]

#slide(title: [Git $!=$ GitHub], animation: anim.sub(anim.reveal("github")))[
  #grid(
    columns: (1fr, 1fr),
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
      #tag("github")[
        *GitHub* #box(inset: (left: 0.2em, bottom: -0.2em), image("logo-github.svg", width: 1cm))

        - Collaboration platform built on top of Git
        - Commercial product
        - Public = https://github.com
        - Internal = https://github.ugent.be
        - Company founded in 2007
        - Bought by Microsoft in 2018
      ]
    ],
  )
]

#slide(title: "github.ugent.be", animation: anim.sub(anim.reveal("features")))[
  *For internal use only:*

  - Only accessible with UGent account
  - Data remains on-premises
  - Research or education (not administration)

  #tag("features")[
    *Basic GitHub features:*

    - Visualization of a Git repository
    - Simple file edits
    - Issue tracker
    - Pull requests
    - Management (permissions, teams, ...)
  ]
]

#slide(title: "github.com", animation: anim.sub(anim.reveal("beyond")))[
  Anyone can create an account

  #tag("beyond")[
    *Goes beyond basic GitHub features:*

    - Continuous integration, a.k.a. "Actions"
    - Copilot + VSCode integration
    - GitHub Pages
    - Public profile
    - ...
  ]
]

#slide(
  title: "Data management aspects",
  animation: {
    import anim: *
    sub(reveal("citations"))
    sub(reveal("zenodo"))
  },
)[
  *License:*

  - Define it at the very start (first commit).
  - Bare minimum: `LICENSE` file + mention in `README.md`.
  - Tutorial repo applies #link("https://reuse.software")[REUSE] recommendations.

  #tag("citations")[
    *Suggest citations for a Git Repo:*

    - Use `CITATION.cff` file (https://citation-file-format.github.io/)
  ]

  #tag("zenodo")[
    *GitHub $!=$ Zenodo*

    - GitHub: live data
    - Zenodo: read-only deposits
  ]
]

#slide(title: "Quality Assurance", animation: anim.sub(anim.reveal("later")))[
  Recommended from *Day 1*:

  - Use a `.gitignore` file to avoid committing unnecessary files.
  - Use a `.editorconfig` file to ensure consistent formatting.
  - Use a `.pre-commit-config.yaml` file to automatically check code quality before committing. See https://pre-commit.com/ for more details.

  #tag("later")[
    Later, you can also consider:

    - Continuous integration (e.g. #link("https://docs.github.com/en/actions")[GitHub Actions]) to automatically run tests on new commits.
  ]
]

#outline-slide("handson")

#slide(title: "Links", animation: anim.sub(anim.reveal("sandbox")))[
  https://github.com/molmod/git-tutorial

  - This presentation
  - Two step-by-step guides:
    + Basic GitHub usage
    + Terminal Git usage

  #tag("sandbox")[
    https://github.ugent.be/tovrstra/sandbox-261015

    Internal UGent repository for experimentation.
  ]
]
