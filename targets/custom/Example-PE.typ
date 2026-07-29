// One-off tailoring for a specific application. Built from the "pe" angle, then
// patched here so content/ stays free of one-offs. Nothing in targets/custom/
// is built by `./build.sh` or `--publish` (the glob is top-level only), and the
// page diff is skipped for it; build it on demand:
//
//   ./build.sh custom/Example-PE
//   ./build.sh --watch custom/Example-PE
//
// Copy this file, rename per company, and edit the summary/skills/bullets.
#import "../../lib/template.typ": render
#import "../../content/profile.typ": profile, role-title-for, summary-for, skills, education
#import "../../content/experience.typ": jobs-for
#import "../../lib/overrides.typ": replace-highlights

// A summary retuned to this posting.
#let summary = [
  Purveyor of boringly effective technology solutions for over 20 years — with
  the Kafka and event-sourcing depth this role centers on.
]

#render(
  profile: profile,
  role-title: role-title-for("pe"),
  summary: summary,
  skills: ("Event Sourcing",) + skills,
  jobs: jobs-for("pe", patch: replace-highlights(
    "BuildOps",
    "First bullet, rewritten for this posting.",
    "Second bullet, rewritten for this posting.",
  )),
  education: education,
  full: false,
)
