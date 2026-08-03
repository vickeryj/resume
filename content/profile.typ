// Everything at the top of the page: contact info, the per-target role title
// and summary paragraph, the italic skills line, and education.
//
// Contact info, skills, and education are shared across every target. The role
// title and summary are keyed by target tag ("pe" / "vpe"), since the framing
// is itself part of the pitch.

#let profile = (
  name: "Joshua Vickery",
  phone: "919-412-0354",
  email: "josh@vickeryj.com",
  location: "Queens, NY",
  links: ((label: "linkedin.com/in/vickeryj", url: "https://linkedin.com/in/vickeryj"),),
)

#let role-title-by-target = (
  pe: "Principal Engineer",
  vpe: "Vice President of Engineering",
)

#let summary-by-target = (
  pe: [
    Purveyor of boringly effective technology solutions for over 20 years: root
    cause fixes that stay fixed, systems that page only when a human is actually
    needed. I'm hands-on by default and delegate as scale demands. My experience
    runs from seed-stage startups to Capital One.
  ],
  vpe: [
    Purveyor of boringly effective technology solutions for over 20 years: root
    cause fixes that stay fixed, systems that page only when a human is actually
    needed. I've led engineering as a CTO, VP of Engineering, and Director —
    growing orgs, hiring and developing managers, opening an international
    office, standing up QA from scratch — and spent recent years in Principal IC
    roles staying sharp on the systems my teams ship. Engineer first, manager
    second.
  ],
)

#let skills = (
  "TypeScript", "Python", "Java", "Ruby", "Swift", "Go", "Scala",
  "Kafka", "AWS", "OTel", "AI-assisted SDLC",
)

#let role-title-for(tag) = role-title-by-target.at(tag)
#let summary-for(tag) = summary-by-target.at(tag)

#let education = (
  (
    institution: "Grinnell College",
    location: "Grinnell, IA",
    degree: "B.A. Computer Science",
    year: "2002",
  ),
)
