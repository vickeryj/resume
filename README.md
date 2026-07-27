# Résumé / CV

Typst sources for a set of tailored résumés and CVs. One template, one shared
history, several targets — so a change to your experience updates every PDF.

## Layout

```
lib/template.typ        Presentation: layout, fonts, colors, section rendering
lib/variants.typ        Per-target tagging (`variant(...)`) and its resolver
content/
  profile.typ           Contact info, skills, education (shared);
                        role title and summary (per target)
  experience.typ        Full work history — the single source of truth
  older_experience.typ  Pre-2013 roles, spelled out for the CV targets
targets/                One file per output; picks a role angle + résumé vs CV
  Resume-PE.typ                  Condensed, for Principal Engineer roles
  Resume-VP.typ                  Condensed, for VP of Engineering roles
  Resume-PE-CV.typ               Full CV, framed for Principal Engineer
  Resume-VP-CV.typ               Full CV, framed for VP of Engineering
build.sh                Build driver
build/                  Generated PDFs (git-ignored)
```

## Build

```sh
./build.sh                     # build every target into build/
./build.sh Resume-VP           # build just one
./build.sh --watch Resume-VP        # live-rebuild while editing
./build.sh --list              # list targets
./build.sh --publish           # build all, then copy PDFs to iCloud
./build.sh --clean             # delete build/
```

`--publish` copies the built PDFs to `PUBLISH_DIR` (set at the top of
`build.sh` — your iCloud Drive).

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
 Targets import `jobs-for("pe")`;
adding a tag means adding its key where the wording diverges. Skills are one
shared list in `content/profile.typ` — the same line on every target.

**Résumé vs CV — length.** Within a job:

- **`highlights`** — shown on *every* target of that role.
- **`more`** — shown only on the **CV** targets (those passing `full: true`).

Set **`recent: false`** on an older job to drop it from the condensed résumés
while keeping it on the CVs.

The tail of the history swaps wholesale: résumés end with the one-paragraph
`earlier-career` entry in `experience.typ`, while the CVs list those pre-2013
roles individually from `content/older_experience.typ`. That's why targets pass
the flag twice — `jobs-for("pe", full: true)` alongside `full: true` on
`render()`; the two must agree.

The role title and summary text live in `content/profile.typ`, keyed by tag, so
a condensed résumé and its CV counterpart automatically share them. To make one
diverge, pass a literal `role-title:`/`summary:` in that target instead.

> **Note:** every post-2013 role is currently `recent: true` with no `more`
> bullets, so today the CVs differ from the résumés only in that expanded
> pre-2013 tail. `recent: false` and `more:` are there when you want more
> separation.

## Adding a new target

Copy an existing file in `targets/`, rename it, and change the tag it asks for
and the `full` flag. To reuse an existing role angle, keep its tag; for a new
angle, pick a new tag, add it to `role-title-by-target` and `summary-by-target`
in `content/profile.typ`, and to the `variant(...)` calls where the wording
should differ — anything untagged falls
through to every target. `./build.sh` picks the file up automatically.
