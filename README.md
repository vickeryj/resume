# Résumé / CV

Typst sources for a set of tailored résumés and CVs. One template, one shared
history, several targets — so a change to your experience updates every PDF.

## Layout

```
lib/template.typ        Presentation: layout, fonts, colors, section rendering
lib/variants.typ        Per-target tagging (`variant(...)`) and its resolver
lib/overrides.typ       Per-job override helpers for one-off tailorings
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
  custom/                        One-off tailorings, excluded from the default build
build.sh                Build driver
build/                  Generated PDFs (git-ignored)
```

## Build

```sh
./build.sh                     # build every target into build/
./build.sh Resume-VP           # build just one
./build.sh custom/Acme-PE      # build a one-off tailoring (see below)
./build.sh --watch Resume-VP        # live-rebuild while editing
./build.sh --list              # list targets
./build.sh --publish           # build all, then copy PDFs to iCloud
./build.sh --clean             # delete build/
./build.sh --open              # build all, then open the page diff in a browser
```

`--publish` copies the built PDFs to `PUBLISH_DIR` (set at the top of
`build.sh` — your iCloud Drive).

## Page diffs

Every build renders each page to a PNG under `build/.pages/` and compares it
against the previous build, so the output says what actually moved:

```
building Resume-PE → build/Resume-PE.pdf
  2 pages → 3 pages
  changed pages: 2 3
```

When pages differ, `build/diff/index.html` gets written. Its default **changes**
view finds the rows of the page that actually differ and crops just those out of
the render, old above new — so you read the changed lines at full size instead of
squinting at two overlaid pages:

```
REMOVED  TypeScript · Python · Ruby · Swift · Go · Scala · Kubernetes · Kafka · AWS
ADDED    TypeScript · Python · Ruby · Swift · Go · Scala · Kafka · AWS
```

The other views answer *where on the page* rather than *what*:

- **tinted page** — the whole page with ink present in only the old render in
  red, only the new in green, and unchanged ink in black.
- **difference** — raw `mix-blend-mode: difference`; identical pixels go black
  and movement glows. The brighten toggle helps with faint shifts.
- **side by side**, **before**, **after** — plain renders.

Zoom applies to every view, and `--open` (first argument, combinable with a
target name) opens the report automatically.

Cropping the changed rows uses [tools/pagediff.py](tools/pagediff.py), which
needs `python3` and macOS's `sips`. Without them the report still builds — it
just falls back to the whole-page views.

The PDFs themselves are not comparable byte-for-byte: Typst embeds a timestamp,
so every build produces different bytes. The page renders are deterministic,
which is what makes the comparison exact. Changing `DIFF_PPI` in `build.sh`
invalidates the cached renders and re-baselines on the next build.

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

## One-off tailorings

For a tweak aimed at a single job posting — a retuned summary, a couple of
rewritten bullets — you don't want a new `variant(...)` tag cluttering
`content/`. That's what the tag system is *not* for: variants are for wording
you'll reuse, one-offs are for a single application.

Put those in `targets/custom/`. A file there is an ordinary target that starts
from an existing angle and patches the resolved data before it reaches
`render()`, so the tweak lives entirely in that one file. The build treats
`targets/custom/` specially: `./build.sh` and `--publish` skip it (the target
glob is top-level only) and the page diff is skipped, so your canonical résumés
stay the committed, built-by-default set. Build one on demand with
`./build.sh custom/<name>` or `--watch custom/<name>`.

Copy [targets/custom/Example-PE.typ](targets/custom/Example-PE.typ) and edit.
The summary, skills, and title are plain arguments you can override outright. To
change a job's bullets, `content/experience.typ`'s `jobs-for(...)` takes a
`patch:` hook — a per-job mapper (or an array of them) run over the history
before it resolves. [lib/overrides.typ](lib/overrides.typ) provides
`replace-highlights(company, ..bullets)`, which swaps a job's highlights for the
ones you pass:

```typ
#import "../../lib/overrides.typ": replace-highlights

jobs: jobs-for("pe", patch: replace-highlights(
  "BuildOps",
  "First bullet, rewritten for this posting.",
  "Second bullet, rewritten for this posting.",
)),
```

Pass an array to touch several jobs:
`patch: (replace-highlights("BuildOps", …), replace-highlights("ShopKeep POS", …))`.
`replace-highlights` is variant-aware: if the job's `highlights` is a whole
`variant(...)`, it repoints every key present (and its `default`) at the new
bullets, so a job's per-target gating survives — a tag the variant never
mentioned still shows nothing.
