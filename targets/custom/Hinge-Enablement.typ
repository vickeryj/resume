// One-off tailoring: Hinge — Senior Engineering Manager, Enablement.
// https://hinge.co/careers/jobs/senior-engineering-manager-enablement
//
// Built from the "vpe" angle (people leadership, org building) and retuned to
// the posting's center of gravity: developer velocity, internal platforms run
// as products, AI-native tooling, CI/testing/observability infrastructure.
//
//   ./build.sh custom/Hinge-Enablement
//   ./build.sh --watch custom/Hinge-Enablement
#import "../../lib/template.typ": render
#import "../../content/profile.typ": profile, education
#import "../../content/experience.typ": jobs-for
#import "../../lib/overrides.typ": replace-highlights

#let summary = [
  Leader and purveyor of boringly effective technology solutions for over 20 years: root
  cause fixes that stay fixed, systems that page only when a human is actually
  needed. I've led engineering as a CTO and Director — growing orgs, developing
  managers, standing up QA from scratch — and spent recent years in Principal
  roles building the CI, testing, and observability infrastructure other
  engineers depend on, and driving AI adoption across a 150-person
  organization.
]

#let skills = (
  "AI-assisted SDLC", "CI/CD", "Distributed Systems", "Data Engineering",
)

#render(
  profile: profile,
  role-title: "Senior Engineering Manager, Enablement",
  summary: summary,
  skills: skills,
  jobs: jobs-for("vpe", patch: (
    replace-highlights(
      "BuildOps",
      "Drove pragmatic AI adoption across the organization: coached developers on efficient use of AI coding tools, including token-efficient workflows, and built deterministic CI checks to complement AI code review — routing mechanical feedback to fast, cheap, consistent tooling and reserving high-cost, non-deterministic analysis for the problems that actually require it.",
      "Created a program for chronically under-owned services that rebuilt institutional knowledge, cut incident remediation times, and surfaced previously hidden work so staffing and product planning reflect reality.",
      "Eliminated an entire class of database migration outages and contained recurring Kafka consumer failures to minor incidents by leading continuous incident analysis and implementing root-cause-level fixes, including predictive Kafka consumer monitoring.",
    ),
    replace-highlights(
      "Independent",
      "Founded The Therapy Homework App: designed and built a platform to help therapists assign and clients complete homework assignments. Product taken through beta and initial public pilot program.",
      "Engineer at Koodos Labs; designed and implemented a friend-finding system leveraging hybrid storage for fast graph lookups without holding the entire social graph in memory.",
    ),
    replace-highlights(
      "Capital One",
      "Championed, designed, and helped to implement distributed tracing across a high-volume banking system with services including Python AWS Lambda, Scala/ZIO, and Go — writing custom OTel agent enhancements for ZIO and Go so every team got usable traces without solving instrumentation itself.",
      "Identified and eliminated $10k+/month compute waste in a security and compliance-focused data ingestion platform via new Kafka consumer partition assignment strategies that took minimum consumer utilization from as low as 0% to 100% of target.",
    ),
    replace-highlights(
      "Namely",
      "Developed a new technical strategy that helped restore developer velocity, shipping 2.5x more major features/engineer in a 6 month period, and improved reliability, with 53% fewer customers impacted by production incidents year over year.",
      "Built integration test harnesses for key systems in JavaScript and Ruby and worked with engineers to fold integration testing into the development process, moving compatibility failures out of production and into development.",
      "Took ownership of and greatly extended a Node.js GraphQL - gRPC gateway in order to dramatically accelerate frontend development.",
    ),
  )),
  education: education,
  full: false,
)
