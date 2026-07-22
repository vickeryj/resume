// Résumé aimed at Principal Engineer roles. Reproduces the source PE résumé.
#import "../lib/template.typ": render
#import "../content/profile.typ": profile
#import "../content/experience.typ": jobs-for
#import "../content/skills.typ": skills-for, education

#render(
  profile: profile,
  role-title: "Principal Engineer",
  summary: [
    Purveyor of boringly effective technology solutions for over 20 years: root
    cause fixes that stay fixed, systems that page only when a human is actually
    needed. I'm hands-on by default and delegate as scale demands. My experience
    runs from seed-stage startups to Capital One.
  ],
  skills: skills-for("pe"),
  jobs: jobs-for("pe"),
  education: education,
  full: false,
)
