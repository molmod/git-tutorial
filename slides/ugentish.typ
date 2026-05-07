// SPDX-FileCopyrightText: © 2026 Toon Verstraelen <Toon.Verstraelen@UGent.be>
// SPDX-License-Identifier: CC-BY-4.0
#import "@preview/touying:0.7.3": *

// Some UGent-specific constants
#let ug = (
  // Extended UGent colors
  blue: rgb("#1e64c8"),
  orange: rgb("#ff7f0e"),
  green: rgb("#2ca02c"),
  red: rgb("#d62728"),
  purple: rgb("#6d28d9"),
  brown: rgb("#8c564b"),
  pink: rgb("#e377c2"),
  gray: rgb("#888888"),
  yellow: rgb("#ffdd00"),
  cyan: rgb("#17becf"),
  dark: rgb("#111111"),

  // Distances
  pad: 0.75cm,
)

// Regular slide
#let slide(
  title: auto,
  align: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }
  let header(self) = {
    set std.align(top)
    show: components.cell.with(inset: 1em)
    set text(fill: self.colors.primary, weight: "semibold", size: 1.2em)
    if title != auto {
      utils.fit-to-width(grow: false, 100%, title)
    } else {
      utils.call-or-display(self, self.store.header)
    }
  }
  let footer(self) = {
    set std.align(bottom)
    set text(size: 0.8em)
    pad(
      ug.pad,
      components.left-and-right(
        text(
          fill: self.colors.neutral-darkest.lighten(40%),
          utils.call-or-display(self, self.store.footer),
        ),
        text(fill: self.colors.neutral-darkest, utils.call-or-display(
          self,
          self.store.footer-right,
        )),
      ),
    )
    if self.store.footer-progress {
      place(bottom, components.progress-bar(
        height: 2pt,
        self.colors.primary,
        self.colors.primary-light,
      ))
    }
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      fill: self.colors.neutral-lightest,
      header: header,
      footer: footer,
    ),
  )
  let new-setting = body => {
    show: std.align.with(self.store.align)
    set text(fill: self.colors.neutral-darkest)
    show: setting
    body
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})

#let title-slide(..args) = touying-slide-wrapper(self => {
  let info = self.info + args.named()
  let body = layout(size => {
    let logo_height = 16.853mm
    grid(
      columns: (auto, 1fr),
      align: left + horizon,
      h(ug.pad),
      v(ug.pad),
      [],
      box(
        height: size.height - ug.pad * 3 - logo_height,
        width: size.width - ug.pad,
        inset: ug.pad,
        fill: ug.blue
      )[
        #set text(fill: white)
        #if info.title != none {
          text(size: 2em, hyphenate: false, info.title)
        }

        #if info.author != none {
          text(size: 0.75em, info.author)
        }

        #if info.date != none {
          text(size: 0.75em, utils.display-info-date(self))
        }
      ],
      [], [
        #v(ug.pad)
        #box(image("logo-ugent.svg"))
        #h(ug.pad)
        #box(image("logo-cmm.svg"))
      ]
    )
  })
  self = utils.merge-dicts(
    self,
    config-page(margin: 0em),
  )
  touying-slide(self: self, body)
})

#let new-section-slide(
  config: (:),
  level: 1,
  numbered: true,
  body,
) = touying-slide-wrapper(self => {
  let slide-body = {
    set std.align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em)
    stack(
      dir: ttb,
      spacing: 1em,
      text(self.colors.neutral-darkest, utils.display-current-heading(
        level: level,
        numbered: numbered,
        style: auto,
      )),
      block(
        height: 2pt,
        width: 100%,
        spacing: 0pt,
        components.progress-bar(
          height: 2pt,
          self.colors.primary,
          self.colors.primary-light,
        ),
      ),
    )
    text(self.colors.neutral-dark, body)
  }
  self = utils.merge-dicts(
    self,
    config-page(fill: self.colors.neutral-lightest),
  )
  touying-slide(self: self, config: config, slide-body)
})

#let focus-slide(
  config: (:),
  align: horizon + center,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: self.colors.neutral-dark, margin: 2em),
  )
  set text(fill: self.colors.neutral-lightest, size: 1.5em)
  touying-slide(self: self, config: config, std.align(align, body))
})


#let ugentish-theme(
  aspect-ratio: "16-9",
  align: horizon,
  header: self => utils.display-current-heading(
    setting: utils.fit-to-width.with(grow: false, 100%),
    depth: self.slide-level,
  ),
  footer: none,
  footer-right: context utils.slide-counter.display()
    + " / "
    + utils.last-slide-number,
  footer-progress: true,
  title: "Untitled",
  author: none,
  date: none,
  ..args,
  body,
) = {
  set document(
    title: title,
    author: author,
    date: date,
  )

  set text(font: "FiraGo", size: 24pt)
  show raw.where(block: true): block.with(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
  )
  show math.equation: set text(font: "Fira Math")
  show raw: set text(font: "Fira Code")
  show link: it => { underline(text(blue.darken(20%))[#it]) }
  set list(marker: [--])

  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      header-ascent: 30%,
      footer-descent: 30%,
      margin: (top: 3em, bottom: 1.5em, x: 2em),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
      datetime-format: "[day] [month repr:long] [year]",
    ),
    config-methods(
      alert: (self: none, body) => text(fill: self.colors.neutral-dark, body),
    ),
    config-colors(
      primary: ug.blue,
      primary-light: luma(65%),
      secondary: ug.yellow,
      neutral-lightest: white,
      neutral-dark: luma(20%),
      neutral-darkest: black,
    ),
    config-info(
      title: title,
      author: author,
      date: date,
    ),
    config-store(
      align: align,
      header: header,
      footer: footer,
      footer-right: footer-right,
      footer-progress: footer-progress,
    ),

    ..args,
  )

  body
}
