// Skills (rendered as the italic inline list under the summary) and education.
// Education is shared; the skills line is ordered per target tag, since the
// ordering itself is part of the pitch.

#let skills-by-target = (
  pe: (
    "TypeScript", "Python", "Ruby", "Swift", "Go", "Scala",
    "Kafka", "DynamoDB", "AWS", "OTel",
  ),
  vpe: (
    "TypeScript", "Swift", "Python", "Go", "Ruby",
    "Kafka", "DynamoDB", "AWS", "OTel", "AI-assisted SDLC",
  ),
)

#let skills-for(tag) = skills-by-target.at(tag)

#let education = (
  (
    institution: "Grinnell College",
    location: "Grinnell, IA",
    degree: "B.A. Computer Science",
    year: "2002",
  ),
)
