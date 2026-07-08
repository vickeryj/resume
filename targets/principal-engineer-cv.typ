// Full CV (complete experience) framed for Principal Engineer roles.
#import "../lib/template.typ": render
#import "../content/profile.typ": profile
#import "../content/experience.typ": jobs
#import "../content/skills.typ": skills, education

#render(
  profile: profile,
  role-title: "Principal Engineer",
  summary: [
    Hands-on technical leader with 15+ years building and scaling distributed
    systems. I set technical direction across teams, raise the engineering bar
    through standards and mentorship, and stay close to the code — driving the
    highest-leverage architectural decisions from design through delivery.
  ],
  jobs: jobs,
  skills: skills,
  education: education,
  full: true,
)
