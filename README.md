# Résumé / CV

Typst sources for a set of tailored résumés and CVs. One template, one shared
history, several targets — so a change to your experience updates every PDF.

## Layout

```
lib/template.typ        Presentation: layout, fonts, colors, section rendering
lib/variants.typ        Per-target tagging (`variant(...)`) and its resolver
content/
  profile.typ           Name, contact info (shared)
  experience.typ        Full work history — the single source of truth
  skills.typ            Skills list (per target) and education (shared)
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

There are two independent axes.

**Role angle — target tags.** Every target passes a tag: `"pe"` (Principal
Engineer) or `"vpe"` (VP of Engineering). `content/experience.typ` holds one
copy of the history; anything that should read differently per role is wrapped
in `variant(...)`:

```typ
lead: variant(
  pe: "Wording for the Principal Engineer targets.",
  vpe: "Wording for the VP of Engineering targets.",
),
highlights: (
  "Bullet shown on every target.",
  variant(vpe: "Bullet only the VPE targets get."),
  variant(pe: "…", default: "…"),   // `default` covers any unlisted tag
),
```

A variant with no entry for the current tag (and no `default`) resolves to
nothing: the field is dropped, the bullet disappears. A whole job can be
limited with `targets: ("vpe",)`.

Inside a bullet list a variant may hold a *list* of bullets, spliced in where
it sits — so a run of same-tag bullets stays under one tag rather than
repeating `variant(...)` on each. When a job shares no bullets at all, the
whole list can be the variant:

```typ
highlights: variant(vpe: ("Org-building bullet.", "Another one."))
```
 Targets import `jobs-for("pe")` /
`skills-for("vpe")`; adding a tag means adding its key where the wording
diverges. Skills live in `content/skills.typ`, one ordered list per tag, since
the ordering is itself part of the pitch.

**Résumé vs CV — length.** Within a job:

- **`highlights`** — shown on *every* target of that role.
- **`more`** — shown only on the **CV** targets (those passing `full: true`).

Set **`recent: false`** on an older job to drop it from the condensed résumés
while keeping it on the CVs.

The summary text lives in each `targets/*.typ` file alongside `role-title`. A
condensed résumé and its CV counterpart share the same summary — edit both if
you want them to diverge.

> **Note:** every role is currently `recent: true` with no `more` bullets, so
> each `-cv` target is byte-for-byte identical to its plain résumé. That
> distinction activates as soon as you mark an older role `recent: false` or
> add `more:` bullets.

## Adding a new target

Copy an existing file in `targets/`, rename it, and change `role-title`,
`summary`, and the `full` flag. To reuse an existing role angle, keep its tag;
for a new angle, pick a new tag and add it to the `variant(...)` calls and to
`skills-by-target` where the wording should differ — anything untagged falls
through to every target. `./build.sh` picks the file up automatically.
