// Target tagging.
//
// Content files hold one copy of the history. Anything that differs between
// targets is wrapped in `variant(...)`, keyed by target tag ("pe", "vpe", …):
//
//   lead: variant(
//     pe: "Wording for the Principal Engineer targets.",
//     vpe: "Wording for the VP of Engineering targets.",
//   )
//
//   highlights: (
//     "Bullet shown on every target.",
//     variant(vpe: "Bullet shown only on the VPE targets."),
//     variant(pe: "…", default: "…"),   // `default` covers unlisted tags
//   )
//
// A variant with no entry for the current tag (and no `default`) resolves to
// none: the field is dropped, the bullet disappears from the list.
//
// Inside a bullet list, a variant may hold a *list* of bullets, which is
// spliced in where it sits. Use it to keep a run of same-tag bullets under one
// tag instead of repeating `variant(...)` on each:
//
//   highlights: (
//     "Bullet shown on every target.",
//     variant(
//       pe: ("Two bullets…", "…only the PE targets get."),
//       vpe: ("One the VPE targets get instead.",),
//     ),
//   )
//
// The whole list can be a variant too, when a job shares no bullets at all:
//
//   highlights: variant(vpe: ("…", "…"))
//
// A whole job can be limited to some targets with `targets: ("vpe",)`.

#let variant(..choices) = (__variant: choices.named())

// Resolve one value for `tag`: plain values pass through untouched.
#let pick(value, tag) = {
  if type(value) == dictionary and "__variant" in value {
    value.__variant.at(tag, default: value.__variant.at("default", default: none))
  } else {
    value
  }
}

// Resolve a bullet list, splicing in any variant that resolved to a list.
#let resolve-list(items, tag) = {
  let out = ()
  for item in items {
    let resolved = pick(item, tag)
    if resolved == none { continue }
    if type(resolved) == array {
      out += resolve-list(resolved, tag)
    } else {
      out.push(resolved)
    }
  }
  out
}

#let resolve-job(job, tag) = {
  let out = (:)
  for (key, value) in job {
    if key == "targets" { continue }
    let resolved = pick(value, tag)
    if resolved == none { continue }
    if key == "highlights" or key == "more" {
      let items = resolve-list(resolved, tag)
      if items.len() > 0 { out.insert(key, items) }
    } else {
      out.insert(key, resolved)
    }
  }
  out
}

// The whole history, resolved for one target tag.
#let resolve-jobs(jobs, tag) = {
  let shown = jobs.filter(j => tag in j.at("targets", default: (tag,)))
  shown.map(j => resolve-job(j, tag))
}
