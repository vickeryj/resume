// Résumé aimed at Principal Engineer roles. Reproduces the source PE résumé.
#import "../lib/template.typ": render
#import "../content/profile.typ": profile, role-title-for, summary-for, skills, education
#import "../content/experience.typ": jobs-for

#render(
  profile: profile,
  role-title: role-title-for("pe"),
  summary: summary-for("pe"),
  skills: skills,
  jobs: jobs-for("pe"),
  education: education,
  full: false,
)
