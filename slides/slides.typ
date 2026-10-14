// SPDX-FileCopyrightText: 2026 Toon Verstraelen <Toon.Verstraelen@UGent.be>
// SPDX-License-Identifier: CC-BY-4.0

// The template packages used here are not (yet) on Typst Universe.
// See instructors.md for how to make them available to Typst.
#import "@ugentish/animo-ugentish:0.1.0": *

// Fletcher is on Universe, no need to install anything
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#show: animo-ugentish.with(
  short: "git",
  sections: (
    basics: "Basic concepts",
    handson: "Hands-on",
  ),
  logos: {
    box(link("https://www.ugent.be", image("logo-ugent.svg")))
    h(0.75cm)
    box(link("https://molmod.ugent.be", image("logo-cmm.svg")))
  },
)

#title-slide(
  "Getting Started with Git(Hub)",
  subtitle: [
    Scientific Computing for Physicists \
    ... and Coffee
  ],
  authors: [Toon Verstraelen \ #link("Toon.Verstraelen@UGent.be")],
  note: [
    Center for Molecular Modeling \
    Department of Physics and Astronomy \
    Faculty of Sciences \
    Ghent University
  ],
)

#outline-slide("basics")

#slide(
  title: [Git = A _distributed_ version control system],
  animation: {
    import anim: *
    sub(reveal("why"))
    sub(reveal("what"))
    sub(reveal("how"))
  },
)[
  #v(1fr)
  #let mypanel(label, title, hue, contents) = tag(
    label, panel(title: title, hue: hue, align(center, box(height: 7cm)[#contents]))
  )

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: deck-pad,
    mypanel("why", "Why?", "blue")[
      #box(image("tabler/user.svg", height: 2cm))
      #box(image("tabler/tool.svg", height: 2cm))
      #box(image("tabler/user.svg", height: 2cm))

      Collaborative development

    ],
    mypanel("what", "What?", "teal")[
      #box(image("tabler/file-code.svg", height: 2cm))
      #box(image("tabler/file-smile.svg", height: 2cm))
      #box(image("tabler/file-type-txt.svg", height: 2cm))

      Shared history \
      of a tree of files
    ],
    mypanel("how", "How?", "green")[
      #box(image("tabler/brand-open-source.svg", height: 2cm))
      #box(image("tabler/database.svg", height: 2cm))
      #box(image("tabler/network.svg", height: 2cm))

      Software \
      Database format \
      Network protocols
    ],
  )

  #v(2fr)
]

#slide(title: "Why care (in academia)?", animation: anim.sub(anim.reveal("uses")))[
  #v(1fr)
  #grid(
    columns: (1fr, 1fr),
    gutter: deck-pad,
    panel(title: "Enables", box(height: 6cm)[
      - Collaboration

      - Incremental development

      - Provenance & attribution

      - Backup
    ]),
    tag("uses", panel(title: "Used for", hue: "green", box(height: 6cm)[
      - Developing (simulation) software

      - Authoring courses, articles, theses, presentations, ...

      - Managing research data
    ])),
  )

  #v(2fr)
]

#slide(
  title: [Anatomy of a _local_ Git "repo(sitory)"],
  animation: {
    import anim: *
    sub(
      reveal("working"),
      apply("tree-working", text.with(fill: ugc.blue)),
    )
    sub(
      reveal("staging"),
      apply("tree-index", text.with(weight: "bold", fill: ugc.orange)),
    )
    sub(
      reveal("history"),
      apply("tree-git", text.with(weight: "bold", fill: ugc.teal)),
    )
  },
)[
  #grid(
    columns: 2,
    align: top,
    gutter: 2cm,
    [
      *Example:* \
      `tovrstra/sandbox`
      #par(leading: 8pt, text(font: "Source Code Pro", size: 18pt, fill: luma(40%))[
        . \
        ├── .git/ \
        │   ├── config \
        │   ├── HEAD \
        │   ├── #tag("tree-index")[index] \
        │   ├── #tag("tree-git")[objects/] \
        │   ├── refs/ \
        │   └── ... \
        ├── #tag("tree-working")[animals.md] \
        ├── #tag("tree-working")[foods.md] \
        ├── #tag("tree-working")[README.md] \
        └── ... \
      ])
    ],
    [
      *Three* locations of your files:
      #table(
        columns: 3,
        inset: 0.5em,
        table.header(
          tag("working", text(weight: "bold", fill: ugc.blue)[Working directory]),
          tag("staging", [#text(weight: "bold", fill: ugc.orange)[Staging area] \ (or index)]),
          tag("history", text(weight: "bold", fill: ugc.teal)[History]),
        ),
        tag("working")[Files being edited],
        tag("staging")[
          Version of files to be added to history
          #place(dx: -3cm, dy: 1cm)[
            #set text(size: 1.5em)
            $stretch(->, size: #150%)_#[`git add`]$
          ]
        ],
        tag("history")[
          Database with all previous versions of the working directory
          #place(dx: -3cm, dy: 1cm)[
            #set text(size: 1.5em)
            $stretch(->, size: #120%)_#[`git commit`]$
          ]
        ],
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

    - ... holds metadata (author, timestamp, parents, ...)

    - ... represents a full snapshot of the working tree at that time
  ]
]

#slide(title: "Git branches refer to commits")[
  #align(center, image("git_repository_2.svg"))

  - A branch points to a commit (and its ancestors): `plot`, `table`, `main`, ...

  - `main` = _default_ branch

  - `plot` was _merged_ into `main`

  - `table` temporarily _diverges_, to be merged later.
]

#slide(title: "Creating new commits")[
  #align(center, image("git_repository_3.svg"))

  + Modify files in the _working directory_.

  + `git add`: Add files to the _staging area_.

  + `git commit`: _Commit_ the staged files $=>$ New commit after current *HEAD*.
]

#slide(background: image("video_terminal.webp", width: 100%))[
  /*#align(center)[
    #text(fill: ugc.yellow, size: 1.5em, weight: "bold")[
      Terminal computers (1987)
    ]
  ]*/
]

#slide(
  title: "Git in the terminal = most complete interface",
  animation: {
    import anim: *
    sub(reveal("subcommands"))
    sub(reveal("frequent"))
  },
)[
  #v(1fr)
  #set align(center)
  #box(align(left,
  ```bash
  # Add an extra line to the README.md
  echo "Thank you for reading!" >> README.md

  # Add the modified file to the staging area
  git add README.md

  # Create a new commit
  git commit -m "Make README more friendly."
  ```
  ))

  #v(1fr)
  #tag("subcommands")[
    Git has many subcommands! (> 100) \
  ]

  #v(1fr)
  #tag("frequent")[
    You only need a handful frequently: \
    `git status`
    #h(1em)
    `git add`
    #h(1em)
    `git commit`
    #h(1em)
    `git push`
    #h(1em)
    `git pull` \
    `git log`
    #h(1em)
    `git diff`
    #h(1em)
    `git switch`
  ]
  #v(2fr)
]

#slide(title: "Distributed or centralized", animation: anim.sub(anim.reveal("scaling")))[
  #grid(
    columns: (1fr, 1.5fr),
    gutter: 1cm,
    [
      #v(0.5fr)
      - Repositories can be "cloned" (full copy of history)

      - Branches can be "pushed" and "pulled"

      - Technically works without central server.

      #v(1fr)
      #tag("scaling")[*Scaling!* E.g. Linux has more than 20000 contributors.]

      #v(2fr)
    ],
    image("centralized.svg", width: 100%),
  )
]

#slide(animation: {
  import anim: *
  sub(reveal("what"))
  sub(reveal("license"))
  sub(reveal("links"))
  sub(reveal("history"))
})[
  #v(1fr)
  #grid(
    columns: (1fr, 1fr),
    align: horizon,
    inset: deck-pad,
    [
      *Git* #box(inset: (left: 0.2em, bottom: -0.2em), image("logo-git.svg", width: 1cm))
    ],
    [
      *GitHub* #box(inset: (left: 0.2em, bottom: -0.2em), image("logo-github.svg", width: 1cm))
    ],
    grid.hline(),
    tag("what")[
      Distributed version control system
    ],
    tag("what")[
      Collaboration platform built on top of Git
    ],
    grid.hline(),
    tag("license")[
      Open source
    ],
    tag("license")[
      Commercial product
    ],
    grid.hline(),
    tag("links")[
      https://git-scm.com/
    ],
    tag("links")[
      https://github.com (public) \
      https://github.ugent.be (internal)
    ],
    grid.hline(),
    tag("history")[
      Created in 2005 \
      to maintain the Linux source.
    ],
    tag("history")[
      Company founded in 2008, \
      bought by Microsoft in 2018.
    ],
  )
  #v(2fr)
]

#slide(animation: {
  import anim: *
  sub(reveal("access"))
  sub(reveal("data"))
  sub(reveal("scope"))
  sub(reveal("features"))
})[
  #v(1fr)
  #grid(
    columns: (1fr, 1fr),
    align: top,
    inset: deck-pad,
    [https://github.ugent.be],
    [https://github.com],
    grid.hline(),
    tag("access")[
      UGent accounts only
    ],
    tag("access")[
      Anyone
    ],
    grid.hline(),
    tag("data")[
      Data remains on premises
    ],
    tag("data")[
      Data in the cloud
    ],
    grid.hline(),
    tag("scope")[
      Research or education
    ],
    tag("scope")[
      Anything goes
    ],
    grid.hline(),
    tag("features")[
      *Basic GitHub features*

      - Issues
      - Pull requests
      - Fine-grained access permissions
      - ...
    ],
    tag("features")[
      *Beyond basic*

      - "Actions" (e.g. continuous integration)
      - Copilot + VSCode integration
      - GitHub Pages
      - Public profile
      - ...
    ]
  )
  #v(2fr)
]

#slide(
  title: [M↓ $=$ Markdown],
  animation: {
    import anim: *
    sub(reveal("rendered"))
    sub(reveal("where"))
    sub(reveal("why"))
  },
)[
  #v(1fr)
  #grid(
    columns: (1.15fr, auto, 0.9fr),
    align: top,
    gutter: deck-pad,
    [
      *You create a README.md text file:*
      ```markdown
      # Git(Hub) tutorial

      This repository contains source materials for the _Git(Hub) tutorial_.

      1. Start with tutorial slides
      1. Go through
         [`handson_web.md`](handson_web.md)
      ```
    ],
    align(horizon, tag("rendered", text(size: 2em, fill: ugc.gray, $->$))),
    tag("rendered")[
      *GitHub renders it as:*

      #panel(hue: "blue")[
        #text(size: 1.5em, weight: "bold")[Git(Hub) tutorial]
        #v(-1em)
        #line(length: 100%, stroke: 1pt + ugc.blue)

        This repository contains source materials for the _Git(Hub) tutorial_.

        + Start with tutorial slides
        + Go through #link("./handson_web.md")[`handson_web.md`].
      ]
    ]
  )

  #v(1fr)
  #tag("where")[
    #text(fill: ugc.blue)[Everywhere on GitHub:]
    `README.md`, issues, pull requests, comments, wikis, ...
  ]

  #tag("why")[
    #text(fill: ugc.blue)[Plain text:]
    readable without rendering $=>$ clean diffs in Git
  ]
  #v(2fr)
]

#slide(
  title: "Data management & GitHub",
  animation: {
    import anim: *
    sub(reveal("citation"))
    sub(reveal("zenodo"))
  },
)[
  #v(1fr)
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: deck-pad,
    panel(title: "License")[
      Define it at the *very start* (first commit).

      *Minimalistic:*
      - `LICENSE` file
      - mention in `README.md`

      *Fine-grained:*
      #link("https://reuse.software")[REUSE]
    ],
    tag("citation", panel(title: "Metadata")[
      - Suggested citation:
        #link("https://citation-file-format.github.io/")[`CITATION.cff`]

      - Topics

      - Website
    ]),
    tag("zenodo", panel(title: "Archive")[
      *GitHub $!=$ Zenodo*

      #set align(center)
      #diagram(
        node-stroke: 2pt,
        edge-stroke: 2pt,
        node((0,0), corner-radius: 2pt, inset: deck-pad)[
          *GitHub* \
          live data
        ],
        edge("-|>")[_Release_],
        node((0,1), corner-radius: 2pt, inset: deck-pad)[
          *Zenodo* \
          frozen data + DOI
        ],
      )

    ])
  )
  #v(2fr)
]

#slide(title: "Quality assurance", animation: anim.sub(anim.reveal("later")))[
  #v(1fr)
  #panel(title: "Day 1")[
    - Use a `.gitignore` file to avoid committing unnecessary files.

    - Use a `.editorconfig` file to ensure consistent formatting.

    - Use a `.pre-commit-config.yaml` file and install `pre-commit` to automatically check code quality before committing. See https://pre-commit.com/ for more details.
  ]

  #v(1fr)
  #tag("later", panel(title: "Later")[
    Continuous integration (e.g. #link("https://docs.github.com/en/actions")[GitHub Actions]) to automatically run tests on new commits.
  ])

  #v(2fr)
]

#outline-slide("handson")

#slide(title: "Link to online tutorial")[
  #v(1fr)
  https://github.com/molmod/git-tutorial

  - This presentation

  - Two step-by-step guides:

    + *GitHub* web interface

    + *Git* & *GitHub* terminal usage

  #v(2fr)
]
