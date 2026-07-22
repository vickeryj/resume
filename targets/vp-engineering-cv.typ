// Full CV (all experience + `more` bullets) framed for VP of Engineering roles.
#import "../lib/template.typ": render
#import "../content/profile.typ": profile, role-title-for, summary-for, skills, education
#import "../content/experience.typ": jobs-for

#render(
  profile: profile,
  role-title: role-title-for("vpe"),
  summary: summary-for("vpe"),
  skills: skills,
  jobs: jobs-for("vpe", full: true),
  education: education,
  full: true,
)
