// Shared résumé/CV template.
//
// `render(...)` returns the full document. Presentation lives here; content
// lives in `content/`; each file in `targets/` picks a role angle and calls
// this. Tweak fonts, colors, and spacing in one place and every target follows.

#let accent = rgb("#1f3a5f")
#let muted = rgb("#555555")
#let rule-color = rgb("#d0d0d0")

// A single job entry.
#let job-entry(job, full: false) = {
  block(above: 0.9em, below: 0.6em)[
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      [
        *#job.role* #h(0.4em)
        #text(fill: accent)[#sym.dot.c] #h(0.4em)
        #job.company
      ],
      text(fill: muted, size: 9pt)[
        #job.start #sym.dash.en #job.end
      ],
    )
    #if job.at("location", default: none) != none {
      text(fill: muted, size: 9pt, style: "italic")[#job.location]
    }
  ]

  if job.at("summary", default: none) != none {
    text(size: 9.5pt)[#job.summary]
  }

  let bullets = job.at("highlights", default: ())
  if full {
    bullets += job.at("more", default: ())
  }
  if bullets.len() > 0 {
    list(
      indent: 0.4em,
      spacing: 0.5em,
      ..bullets.map(b => text(size: 9.5pt)[#b]),
    )
  }
}

#let section(title) = {
  v(0.4em)
  text(
    size: 11pt,
    weight: "bold",
    fill: accent,
    tracking: 0.5pt,
  )[#upper(title)]
  v(-0.3em)
  line(length: 100%, stroke: 0.5pt + rule-color)
  v(0.1em)
}

#let render(
  profile: (:),
  role-title: "",
  summary: "",
  jobs: (),
  skills: (),
  education: (),
  full: false,
) = {
  set document(
    title: profile.name + " — " + role-title,
    author: profile.name,
  )
  set page(
    paper: "us-letter",
    margin: (x: 0.75in, y: 0.7in),
    footer: context [
      #set text(size: 8pt, fill: muted)
      #grid(
        columns: (1fr, auto),
        [#profile.name #sym.dash.en #role-title],
        [#counter(page).display("1 / 1", both: true)],
      )
    ],
  )
  set text(font: ("Helvetica Neue", "Arial"), size: 10pt, fill: rgb("#1a1a1a"))
  set par(justify: false, leading: 0.6em)

  // Header
  align(center)[
    #text(size: 22pt, weight: "bold")[#profile.name]
    #v(0.1em)
    #text(size: 12pt, fill: accent, tracking: 1pt)[#upper(role-title)]
    #v(0.4em)
    #text(size: 9pt, fill: muted)[
      #profile.email
      #sym.dot.c #profile.phone
      #sym.dot.c #profile.location
      #if profile.at("links", default: ()).len() > 0 {
        for link-item in profile.links {
          [#sym.dot.c #link(link-item.url)[#link-item.label]]
        }
      }
    ]
  ]
  v(0.6em)

  // Summary
  if summary != "" {
    section("Summary")
    text(size: 9.5pt)[#summary]
    v(0.3em)
  }

  // Experience
  if jobs.len() > 0 {
    let shown = if full { jobs } else { jobs.filter(j => j.at("recent", default: true)) }
    section("Experience")
    for job in shown {
      job-entry(job, full: full)
    }
  }

  // Skills
  if skills.len() > 0 {
    section("Skills")
    for group in skills {
      block(above: 0.4em, below: 0.4em)[
        *#group.category:* #text(size: 9.5pt)[#group.items.join(" · ")]
      ]
    }
  }

  // Education
  if education.len() > 0 {
    section("Education")
    for edu in education {
      block(above: 0.3em)[
        #grid(
          columns: (1fr, auto),
          [*#edu.degree*, #edu.institution],
          text(fill: muted, size: 9pt)[#edu.year],
        )
      ]
    }
  }
}
