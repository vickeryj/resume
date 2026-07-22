// Résumé aimed at VP of Engineering roles.
#import "../lib/template.typ": render
#import "../content/profile.typ": profile
#import "../content/experience.typ": jobs-for
#import "../content/skills.typ": skills-for, education

#render(
  profile: profile,
  role-title: "Vice President of Engineering",
  summary: [
    Purveyor of boringly effective technology solutions for over 20 years: root
    cause fixes that stay fixed, systems that page only when a human is actually
    needed. I've led engineering as a CTO and Director — growing orgs, hiring
    and developing managers, opening an international office, standing up QA
    from scratch — and spent recent years in Principal IC roles staying sharp
    on the systems my teams ship. Engineer first, manager second.
  ],
  skills: skills-for("vpe"),
  jobs: jobs-for("vpe"),
  education: education,
  full: false,
)
