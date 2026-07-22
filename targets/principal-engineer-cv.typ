// Full CV (all experience + `more` bullets) framed for Principal Engineer roles.
#import "../lib/template.typ": render
#import "../content/profile.typ": profile, role-title-for, summary-for, skills, education
#import "../content/experience.typ": jobs-for

#render(
  profile: profile,
  role-title: role-title-for("pe"),
  summary: summary-for("pe"),
  skills: skills,
  jobs: jobs-for("pe", full: true),
  education: education,
  full: true,
)
