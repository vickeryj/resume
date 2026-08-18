// One-off tailoring: Betterment — Sr. Staff Engineer, AI Platform (NYC).
// https://www.betterment.com/careers/current-openings/job?gh_jid=7821707
//
// Built from the "pe" angle: a hands-on staff-level IC who sets technical
// direction, on a platform team whose customers are other engineers. The
// posting's center of gravity is shared infrastructure and internal libraries
// that let product teams ship AI features, pragmatic judgment about where AI
// belongs, production quality and auditability in a regulated financial
// services environment, and mentoring senior engineers.
//
// The levers this file pulls that the stock PE résumé doesn't. All of them are
// ordering and emphasis — every claim is one content/ already makes:
//   - the AI-adoption bullet leads BuildOps instead of sitting second; it is
//     the closest thing in the history to "clear judgment about when to use AI
//     and when not to," and it is about developer workflow across an org
//   - Capital One and Namely are ordered platform-first: the work that other
//     teams consumed (OTel agents, the GraphQL gateway, test harnesses) ahead
//     of the work that was one team's
//   - regulated environments surfaced by position: Capital One's security and
//     compliance framing stays, and the 21 CFR Part 11 clinical systems lead
//     the Earlier Career paragraph instead of trailing it
//   - React/GraphQL/Ruby pulled onto the skills line for the fullstack ask —
//     each one is in content/ already (SquareFoot, Namely)
//
// Known gap, deliberately not papered over: the posting asks for deep LLM
// systems expertise — prompt engineering, agentic workflows, eval frameworks.
// The history has AI-assisted SDLC work, not LLM product platform work. This
// file leads with the real adjacent thing and lets the reader judge; it does
// not restate CI tooling as an evaluation framework.
//
//   ./build.sh custom/Betterment-AI-Platform
//   ./build.sh --watch custom/Betterment-AI-Platform
#import "../../lib/template.typ": render
#import "../../content/profile.typ": profile, education
#import "../../content/experience.typ": jobs-for
#import "../../lib/overrides.typ": replace-highlights, replace-lead

#let summary = [
  Purveyor of boringly effective technology solutions for over 20 years: root
  cause fixes that stay fixed, systems that page only when a human is actually
  needed. I'm hands-on by default and delegate as scale demands. Recent years
  have been principal roles building the infrastructure other engineers depend
  on — tracing, CI, correctness enforcement — and driving pragmatic AI adoption
  across a 150-person organization: routing the mechanical work to fast,
  deterministic tooling and spending the expensive non-deterministic analysis
  only where it earns its keep. My experience runs from seed-stage startups to
  Capital One.
]

#let skills = (
  "AI-assisted SDLC", "TypeScript", "Python", "Ruby", "Java",
  "React", "GraphQL", "Kafka", "AWS", "OTel",
)

#render(
  profile: profile,
  role-title: "Senior Staff Engineer, AI Platform",
  summary: summary,
  skills: skills,
  jobs: jobs-for("pe", patch: (
    // AI judgment first — the bullet is about org-wide developer workflow and
    // about which problems deserve a non-deterministic tool. Then correctness
    // enforcement, then production reliability.
    replace-highlights(
      "BuildOps",
      "Drove pragmatic AI adoption across the org: coached developers on efficient use of AI coding (including token-efficient workflows), and built deterministic CI checks to complement AI code review — routing mechanical feedback to fast, cheap, consistent tooling and reserving high-cost, non-deterministic analysis for the problems that actually require it.",
      "Designed, prototyped, and oversaw the implementation of an event capture system for inventory data that previously lacked a source of truth and required hundreds of person-hours to reconcile. The system provides enforcement mechanisms against bypass, fully automated reconciliation, and drove data errors to zero.",
      "Eliminated an entire class of database migration outages and contained recurring Kafka consumer failures to minor incidents by leading continuous incident analysis and implementing root-cause-level fixes, including predictive Kafka consumer monitoring.",
    ),
    // Regulated financial services, and instrumentation shipped as something
    // eleven teams consumed rather than each solved for themselves.
    replace-highlights(
      "Capital One",
      "Championed, designed, and helped to implement distributed tracing across a high-volume banking system with services including Python AWS Lambda, Scala/ZIO, and Go — writing custom OTel agent enhancements for ZIO and Go so every team got usable traces without solving instrumentation itself.",
      "Identified and eliminated $10k+/month compute waste in a security and compliance-focused data ingestion platform. Proposed, validated, and helped implement new Kafka consumer partition assignment strategies that took minimum and average consumer utilization from as low as 0% to 100% of target.",
    ),
    // Internal platform work first: the GraphQL gateway and the test harnesses
    // are the two pieces of this history that other teams built on top of.
    replace-highlights(
      "Namely",
      "Took ownership of, and greatly extended a Node.js GraphQL - gRPC gateway in order to dramatically accelerate frontend development.",
      "Built integration test harnesses for key systems in JavaScript and Ruby, and worked with engineers to add integration testing into the development process, helping teams identify compatibility issues during development, rather than in production.",
      "Developed a new technical strategy that helped restore developer velocity, shipping 2.5x more major features/engineer in a 6 month period, and improved reliability, with 53% fewer customers impacted by production incidents year over year.",
    ),
    // Fullstack, still shipping, while owning direction — in that order.
    replace-highlights(
      "SquareFoot",
      "Regularly shipped iOS, Rails, and React code while setting technical direction for the platform.",
      "Designed, prototyped, and oversaw the replacement of the commercial real estate data ingestion pipeline.",
    ),
    // Regulated-systems history led with, rather than buried.
    replace-lead(
      "Earlier Career — 2002 - 2013",
      "Healthcare and clinical trial systems in Java, 21 CFR Part 11 compliant, plus an approximate-matching search engine for audio clips. Then an early iPhone-era mobile engineer and lead: brought PatientKeeper's Mobile Clinical Results to market on iPhone and iPad leading a team of 6, rewrote the WHERE app from scratch, and shipped a highly optimized address book library at CircleBack that dropped into existing apps. As an independent contractor, built the Harvest Time Tracker, an Oxford dictionary app, and Medaxion's anesthesiology billing app.",
    ),
  )),
  education: education,
  full: false,
)
