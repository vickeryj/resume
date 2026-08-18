// One-off tailoring: Capital One — Sr. Manager, Software Engineering, iOS
// (Enterprise Platform Technology), New York.
// https://capitalone.wd12.myworkdayjobs.com/Capital_One/job/New-York-NY/Sr-Manager--Software-Engineering--iOS--Enterprise-Platform-Technology-_R248392-2
//
// A hands-on manager of mobile developers: 4+ years people management (7+
// preferred) and 4+ years building iOS apps, owning delivery of platform
// components, reviewing PRs for Swift idiom, mentoring, and partnering with
// Quality Engineering, UX, and Product. Preferred qual calls out interactive
// AI tooling beyond code completion.
//
// Built from the "vpe" angle, since this is a management posting. The levers,
// all of them ordering and position — every claim is one content/ already
// makes:
//   - the mobile spine made visible: the summary walks the actual path
//     (iPhone-era lead → Mobile Lead → Director of Mobile → hired to build
//     SquareFoot's first iOS app → VPE → CTO), which the stock VPE summary
//     leaves implicit
//   - AI tooling leads BuildOps, using the bullet the pe targets carry; it is
//     the preferred qualification stated almost exactly
//   - SquareFoot ordered management-first, with the still-shipping-iOS bullet
//     directly behind it; QA from zero kept for the Quality Engineering partner
//   - Namely trimmed to velocity and test harnesses; the Kubernetes deep dive
//     is real but irrelevant to a mobile org
//   - Earlier Career left alone: it already leads with the iPhone-era work
//
// Note: Josh was a Lead Engineer at Capital One from 2022 to 2025, so the
// history already carries the internal context this posting assumes.
//
//   ./build.sh custom/CapitalOne-iOS-Manager
//   ./build.sh --watch custom/CapitalOne-iOS-Manager
#import "../../lib/template.typ": render
#import "../../content/profile.typ": profile, education
#import "../../content/experience.typ": jobs-for
#import "../../lib/overrides.typ": replace-highlights

#let summary = [
  Purveyor of boringly effective technology solutions for over 20 years: root
  cause fixes that stay fixed, systems that page only when a human is actually
  needed. I came up through mobile — an early iPhone-era engineer and lead, then
  Mobile Lead and Director of Mobile at ShopKeep, then hired at SquareFoot to
  build its first iOS app and promoted to VP of Engineering and CTO. I've grown
  orgs, hired and developed managers, opened an international office, and stood
  up QA from scratch, and I've spent recent years in Principal IC roles staying
  sharp on the systems my teams ship. Engineer first, manager second.
]

#let skills = (
  "Swift", "iOS", "AI-assisted SDLC", "TypeScript", "Ruby", "Java",
  "React", "AWS", "CI/CD",
)

#render(
  profile: profile,
  role-title: "Sr. Manager, Software Engineering, iOS",
  summary: summary,
  skills: skills,
  jobs: jobs-for("vpe", patch: (
    // AI tooling first — the preferred qualification, and it is about coaching
    // developers, not about personal productivity. Then ownership and
    // reliability, the two things a manager is actually accountable for.
    replace-highlights(
      "BuildOps",
      "Drove pragmatic AI adoption across the org: coached developers on efficient use of AI coding (including token-efficient workflows), and built deterministic CI checks to complement AI code review — routing mechanical feedback to fast, cheap, consistent tooling and reserving high-cost, non-deterministic analysis for the problems that actually require it.",
      "Created a program for chronically under-owned services that rebuilt institutional knowledge, cut incident remediation times, and surfaced previously hidden work so staffing and product planning reflect reality.",
      "Eliminated an entire class of database migration outages and contained recurring Kafka consumer failures to minor incidents by leading continuous incident analysis and implementing root-cause-level fixes.",
    ),
    // Velocity and quality, the mobile-org concerns; the Kubernetes work is
    // dropped rather than reframed.
    replace-highlights(
      "Namely",
      "Developed a new technical strategy that helped restore developer velocity, shipping 2.5x more major features/engineer in a 6 month period, and improved reliability, with 53% fewer customers impacted by production incidents year over year.",
      "Built integration test harnesses for key systems and worked with engineers to add integration testing into the development process, helping teams identify compatibility issues during development, rather than in production.",
    ),
    // Management first, hands-on iOS immediately behind it, then the QA org.
    replace-highlights(
      "SquareFoot",
      "Grew engineering from 4 to 25 engineers across three teams, hiring and developing 3 engineering managers, and building the interview and leveling processes to support the growth.",
      "Remained a working engineer throughout — regularly shipped iOS, Rails, and React code, and designed and oversaw the replacement of the commercial real estate data ingestion pipeline — while setting technical direction for the platform.",
      "Created the company's QA department from zero: hired its leadership, defined its charter, and integrated it into the development process.",
      "Opened and scaled a successful engineering office in Belfast — sourcing leadership, establishing hiring pipelines, and integrating a remote team into a NYC-centered engineering culture years before remote was default.",
    ),
  )),
  education: education,
  full: false,
)
