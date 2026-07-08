# Résumé / CV

Typst sources for a set of tailored résumés and CVs. One template, one shared
history, several targets — so a change to your experience updates every PDF.

## Layout

```
lib/template.typ        Presentation: layout, fonts, colors, section rendering
content/
  profile.typ           Name, contact info (shared)
  experience.typ        Full work history — the single source of truth
  skills.typ            Skills list and education (shared)
targets/                One file per output; picks a role angle + résumé vs CV
  principal-engineer.typ         Condensed, for Principal Engineer roles
  vp-engineering.typ             Condensed, for VP of Engineering roles
  principal-engineer-cv.typ      Full CV, framed for Principal Engineer
  vp-engineering-cv.typ          Full CV, framed for VP of Engineering
build.sh                Build driver
build/                  Generated PDFs (git-ignored)
```

## Build

```sh
./build.sh                     # build every target into build/
./build.sh vp-engineering      # build just one
./build.sh --watch vp-engineering   # live-rebuild while editing
./build.sh --list              # list targets
./build.sh --clean             # delete build/
```

Requires [Typst](https://typst.app): `brew install typst`.

## How targeting works

`content/experience.typ` holds every job. Each job has two bullet lists:

- **`highlights`** — shown on *every* target. Your strongest, most portable wins.
- **`more`** — shown only on the **CV** targets (those passing `full: true`).

Set **`recent: false`** on an older job to drop it from the condensed résumés
while keeping it on the CVs.

The **role angle** comes from each `targets/*.typ` file, which sets the
`role-title` and a tailored `summary`. The condensed résumés and their CV
counterparts share the same summary text — edit both if you want them to
diverge.

> **Note:** the current history lists every role with `recent: true` and no
> `more` bullets, so the `-cv` targets are byte-for-byte identical to the plain
> résumés today. The distinction activates as soon as you mark an older role
> `recent: false` (drops it from the résumé, keeps it on the CV) or add `more:`
> bullets (CV-only detail).

## Adding a new target

Copy an existing file in `targets/`, rename it, and change `role-title`,
`summary`, and the `full` flag. `./build.sh` picks it up automatically.
