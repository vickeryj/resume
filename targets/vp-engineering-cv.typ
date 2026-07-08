// Full CV (all experience + `more` bullets) framed for VP of Engineering roles.
#import "../lib/template.typ": render
#import "../content/profile.typ": profile
#import "../content/experience.typ": jobs
#import "../content/skills.typ": skills, education

#render(
  profile: profile,
  role-title: "Vice President of Engineering",
  summary: [
    Engineering leader who scales organizations, not just systems. Over 20 years
    hands-on, I've built and led high-performing teams from seed-stage startups
    to Capital One — growing orgs, standing up QA and remote offices, and turning
    under-maintained systems into reliable ones. Hands-on by default; I delegate
    as scale demands.
  ],
  skills: skills,
  jobs: jobs,
  education: education,
  full: true,
)
