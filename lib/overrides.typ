// Per-job overrides for one-off targets.
//
// These are for tailoring a single application without touching content/. Each
// helper returns a *per-job mapper*; feed it to `jobs-for`'s `patch` hook:
//
//   jobs: jobs-for("pe", patch: replace-highlights("BuildOps", "…", "…"))
//
// `patch` also takes an array of mappers, to tweak several jobs in one target:
//
//   patch: (replace-highlights("BuildOps", …), replace-highlights("ShopKeep POS", …))

#import "variants.typ": variant

// Replace the highlights of the job at `company` with `bullets`.
//
// If that job's `highlights` is a variant (whole-field, e.g. `variant(vpe: …)`),
// every key present — plus its `default` — is repointed at `bullets`, so the
// replacement holds whichever target is built and the job's per-target gating is
// preserved (a tag the variant never mentioned still shows nothing). Otherwise
// the field is a plain array and is replaced outright.
#let replace-highlights(company, ..bullets) = job => {
  if job.at("company", default: none) != company {
    job
  } else {
    let new = bullets.pos()
    let cur = job.at("highlights", default: none)
    if type(cur) == dictionary and "__variant" in cur {
      let choices = (:)
      for (key, _) in cur.__variant { choices.insert(key, new) }
      job + (highlights: variant(..choices))
    } else {
      job + (highlights: new)
    }
  }
}

// Replace the lead paragraph of a job with `body`.
//
// `key` matches either the job's `company` or its `heading` — the latter so the
// headingless-company entries (`earlier-career`) can be reframed too. Variant
// leads are repointed key by key, exactly as `replace-highlights` does.
#let replace-lead(key, body) = job => {
  if key not in (job.at("company", default: none), job.at("heading", default: none)) {
    job
  } else {
    let cur = job.at("lead", default: none)
    if type(cur) == dictionary and "__variant" in cur {
      let choices = (:)
      for (k, _) in cur.__variant { choices.insert(k, body) }
      job + (lead: variant(..choices))
    } else {
      job + (lead: body)
    }
  }
}
