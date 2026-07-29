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
