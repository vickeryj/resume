// Shared résumé/CV template.
//
// `render(...)` returns the full document. Presentation lives here; content
// lives in `content/`; each file in `targets/` picks a role angle and calls
// this. Tweak fonts, colors, and spacing in one place and every target follows.
//
// Design matches the original PE résumé (Pages/Avenir Next) measured from its
// PDF: 10pt body on 14pt baselines, 14pt Avenir Next Medium section headers,
// 8pt bold all-caps job headings, 9pt italic skills line, 14pt bold name.
// Spacing values below are in pt and were derived from baseline-to-baseline
// distances in the source PDF.

#let font = ("Avenir Next", "Helvetica Neue", "Arial")
#let ink = rgb("#444444")
#let muted = rgb("#606060")

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

#let job-entry(job, full: false, first: false) = {
  // Heading and lead stay in one unbreakable block so a page break never
  // strands the heading alone at the bottom of a page.
  block(above: if first { 11.3pt } else { 15.4pt }, breakable: false)[
    #block(below: 8.4pt)[#text(weight: "bold", size: 8pt)[#job-heading(job)]]
    #if job.at("lead", default: none) != none { job.lead }
  ]

  let bullets = job.at("highlights", default: ())
  if full { bullets += job.at("more", default: ()) }
  if bullets.len() > 0 {
    list(marker: [•], indent: 0em, body-indent: 6pt, spacing: 8.85pt, ..bullets)
  }
}

#let section(title) = {
  block(above: 17.5pt, below: 12.1pt)[
    #text(size: 14pt, weight: "medium", fill: ink)[#title]
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
  set page(paper: "us-letter", margin: (x: 1in, top: 76pt, bottom: 1in))
  set text(font: font, size: 10pt, fill: ink)
  set par(justify: false, leading: 6.85pt, spacing: 8.85pt)

  // Header
  text(size: 14pt, weight: "bold")[#profile.name]
  block(above: 12.1pt)[
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
      block(above: 11.9pt)[
        #text(style: "italic", size: 9pt, fill: muted)[#skills.join(" · ")]
      ]
    }
  }

  // Experience
  if jobs.len() > 0 {
    let shown = if full { jobs } else { jobs.filter(j => j.at("recent", default: true)) }
    section("Experience")
    for (i, job) in shown.enumerate() { job-entry(job, full: full, first: i == 0) }
  }

  // Education
  if education.len() > 0 {
    section("Education")
    for edu in education {
      par[#edu.institution, #edu.location #sym.dash.em #edu.degree, #edu.year]
    }
  }
}
