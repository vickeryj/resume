// Skills and education, shared across targets. Reorder/retitle groups freely;
// individual targets can override these by passing their own lists to render().

#let skills = (
  (category: "Leadership", items: (
    "Technical strategy", "Org design", "Mentorship", "Cross-functional partnership", "Hiring",
  )),
  (category: "Architecture", items: (
    "Distributed systems", "Service-oriented design", "Data pipelines", "API design", "Observability",
  )),
  (category: "Platforms", items: (
    "AWS", "Kubernetes", "PostgreSQL", "Kafka", "Terraform",
  )),
  (category: "Languages", items: (
    "Go", "Python", "TypeScript", "Ruby", "SQL",
  )),
)

#let education = (
  (
    degree: "B.S. in Computer Science",
    institution: "University Name",
    year: "Year",
  ),
)
