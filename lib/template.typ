// Shared résumé/CV template.
//
// `render(...)` returns the full document. Presentation lives here; content
// lives in `content/`; each file in `targets/` picks a role angle and calls
// this. Tweak fonts, colors, and spacing in one place and every target follows.
//
// Design mirrors the Avenir Next, left-aligned, monochrome layout from the
// original PE résumé: light-weight section headers, single-line all-caps job
// headings, and skills as an italic inline list under the summary.

#let font = ("Avenir Next", "Helvetica Neue", "Arial")
#let ink = rgb("#2b2b2b")
#let muted = rgb("#555555")

// Build the all-caps job heading line, e.g.
//   PRINCIPAL ENGINEER, BUILDOPS; REMOTE — DEC 2025 - JUN 2026
#let job-heading(job) = {
  let line = job.at("heading", default: none)
  if line == none {
    line = job.role
    if job.at("company", default: none) != none { line += ", " + job.company }
    if job.at("location", default: none) != none { line += "; " + job.location }
    if job.at("start", default: none) != none {
      line += " — " + job.start + " - " + job.end
    }
  }
  upper(line)
}

#let job-entry(job, full: false) = {
  block(above: 0.9em, below: 0.5em, breakable: false)[
    #text(weight: "bold", size: 9pt, tracking: 0.2pt)[#job-heading(job)]
  ]

  if job.at("lead", default: none) != none {
    text[#job.lead]
    v(0.1em)
  }

  let bullets = job.at("highlights", default: ())
  if full { bullets += job.at("more", default: ()) }
  if bullets.len() > 0 {
    list(marker: [•], indent: 0em, body-indent: 0.5em, spacing: 0.55em, ..bullets)
  }
}

#let section(title) = {
  v(0.7em, weak: true)
  block(above: 0.7em, below: 0.35em)[
    #text(size: 15pt, weight: "regular", fill: ink)[#title]
  ]
}

#let render(
  profile: (:),
  role-title: "",
  summary: none,
  skills: (),
  jobs: (),
  education: (),
  full: false,
) = {
  set document(
    title: profile.name + " — " + role-title,
    author: profile.name,
  )
  set page(paper: "us-letter", margin: (x: 1in, y: 0.85in))
  set text(font: font, size: 10.5pt, fill: ink)
  set par(justify: false, leading: 0.62em, spacing: 0.9em)

  // Header
  text(size: 19pt, weight: "bold")[#profile.name]
  v(0.15em)
  block[
    #set text(fill: muted, size: 10.5pt)
    #let bits = (profile.at("phone", default: none), profile.email, profile.at("location", default: none))
    #bits.filter(b => b != none).join(h(2em))
    #for l in profile.at("links", default: ()) {
      [#h(2em)#link(l.url)[#l.label]]
    }
  ]

  // Summary + skills
  if summary != none or skills.len() > 0 {
    section("Summary")
    if summary != none { text[#summary] }
    if skills.len() > 0 {
      v(0.2em)
      text(style: "italic", fill: muted)[#skills.join(" · ")]
    }
  }

  // Experience
  if jobs.len() > 0 {
    let shown = if full { jobs } else { jobs.filter(j => j.at("recent", default: true)) }
    section("Experience")
    for job in shown { job-entry(job, full: full) }
  }

  // Education
  if education.len() > 0 {
    section("Education")
    for edu in education {
      block(above: 0.3em)[
        #edu.institution, #edu.location #sym.dash.em #edu.degree, #edu.year
      ]
    }
  }
}
