// Condensed résumé aimed at VP of Engineering roles.
#import "../lib/template.typ": render
#import "../content/profile.typ": profile
#import "../content/experience.typ": jobs
#import "../content/skills.typ": skills, education

#render(
  profile: profile,
  role-title: "Vice President of Engineering",
  summary: [
    Engineering leader who scales organizations, not just systems. I've grown
    and led multi-team orgs, owned delivery and reliability at scale, and
    partnered with product and executive leadership to turn strategy into
    shipped outcomes — while keeping engineers growing and retained.
  ],
  jobs: jobs,
  skills: skills,
  education: education,
  full: false,
)
