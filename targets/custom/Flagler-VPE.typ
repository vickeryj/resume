// One-off tailoring: Flagler Health — Vice President, Engineering (NYC).
// https://jobs.ashbyhq.com/flaglerhealth/6a17d368-45ec-46b5-bebf-1c2378702128
//
// Built from the "vpe" angle and retuned to the posting: a foundational exec
// role scaling a distributed org across NYC and Vancouver, owning recruiting
// and org design, and running reliable, HIPAA-compliant systems that carry
// real-time patient communication and long-running async workflows.
//
// The levers this file pulls that the stock VP résumé doesn't. Note that these
// are ordering and emphasis only — every claim is the one content/ already
// makes. Don't let the posting's vocabulary talk you into describing work as
// something it wasn't.
//   - healthcare surfaced by position: the 21 CFR Part 11 / clinical-results
//     history leads the Earlier Career paragraph instead of trailing it
//   - two-office distribution — Belfast as the NYC/Vancouver rhyme
//   - regulated + async reliability — Kafka, migrations, tracing pulled up
//
//   ./build.sh custom/Flagler-VPE
//   ./build.sh --watch custom/Flagler-VPE
#import "../../lib/template.typ": render
#import "../../content/profile.typ": profile, education
#import "../../content/experience.typ": jobs-for
#import "../../lib/overrides.typ": replace-highlights, replace-lead

#let summary = [
  I've led engineering as a CTO, VP of Engineering, and Director — growing orgs,
  hiring and developing managers, opening and integrating a second engineering
  office across an ocean — and spent recent years in Principal roles on
  regulated, high-volume systems. I started out in healthcare, on clinical
  results and 21 CFR Part 11 clinical trial systems, and most recently founded a
  platform for therapists and their clients. Engineer first, manager second.
]

#let skills = (
  "Org Design & Hiring", "Distributed Teams", "HIPAA & Regulated Environments",
  "AWS", "Kafka", "CI/CD", "Observability", "AI-assisted SDLC",
)

#render(
  profile: profile,
  role-title: "Vice President, Engineering",
  summary: summary,
  skills: skills,
  jobs: jobs-for("vpe", patch: (
    // Reliability and operational maturity in a 150-person org: correctness
    // enforcement, ownership of orphaned services, async failure containment.
    replace-highlights(
      "BuildOps",
      "Founded the FinancialOS Engineering team: designed, prototyped, and oversaw an event capture system for inventory data that previously lacked a source of truth and took hundreds of person-hours to reconcile. It enforces against bypass, reconciles fully automatically, and drove data errors to zero.",
      "Eliminated an entire class of database migration outages and contained recurring Kafka consumer failures to minor incidents by leading continuous incident analysis and implementing root-cause-level fixes, including predictive Kafka consumer monitoring.",
      "Created a program for chronically under-owned services that rebuilt institutional knowledge, cut incident remediation times, and surfaced previously hidden work so staffing and product planning reflect reality.",
    ),
    // Healthcare, and the hiring work, made explicit.
    replace-highlights(
      "Independent",
      "Founded The Therapy Homework App: designed and built a platform to help therapists assign and clients complete homework assignments. Product taken through beta and initial public pilot program.",
      "Principal at withforward.com; technical screening of candidates and consulting with clients to help shape their engagement. Engineer at Koodos Labs, on a friend-finding system built for fast graph lookups without holding the entire social graph in memory.",
    ),
    // Regulated-industry credibility: observability and cost/throughput work
    // across 11 teams in banking and security.
    replace-highlights(
      "Capital One",
      "Championed, designed, and helped to implement distributed tracing across a high-volume banking system with services including Python AWS Lambda, Scala/ZIO, and Go. Wrote custom enhancements to OTel agents for ZIO and Go.",
      "Identified and eliminated $10k+/month compute waste in a security and compliance-focused data ingestion platform via new Kafka consumer partition assignment strategies that took minimum consumer utilization from as low as 0% to 100% of target.",
    ),
    // Velocity and reliability as an outcome a leader owns.
    replace-highlights(
      "Namely",
      "Developed a new technical strategy that helped restore developer velocity, shipping 2.5x more major features/engineer in a 6 month period, and improved reliability, with 53% fewer customers impacted by production incidents year over year.",
      "Built integration test harnesses for key systems and folded integration testing into the development process, moving compatibility failures out of production and into development.",
      "Deep dive into Kubernetes cluster health with staff engineers in SRE and Product Engineering to identify latency issues causing customer-facing slowness and preventing reliable response-time-based alerting.",
    ),
    // The closest analogue to this role: two offices, two time zones, one org.
    // The VP of Engineering title itself now comes from content/ — the shared
    // lead spells out the staff → VPE → CTO progression on every target.
    replace-highlights(
      "SquareFoot",
      "Grew engineering from 4 to 25 engineers across three teams, hiring and developing 3 engineering managers, and building the interview and leveling processes to support the growth.",
      "Opened and scaled a second engineering office in Belfast — sourcing leadership, establishing hiring pipelines, and integrating a remote team into a NYC-centered engineering culture years before remote was default.",
      "Created the company's QA department from zero: hired its leadership, defined its charter, and integrated it into the development process.",
      "Remained a working engineer throughout — designed and oversaw the replacement of the commercial real estate data ingestion pipeline, and regularly shipped iOS, Rails, and React code — while setting technical direction for the platform.",
    ),
    // Healthcare and regulatory history led with, rather than buried.
    replace-lead(
      "Earlier Career — 2002 - 2013",
      "Healthcare and clinical trial systems in Java, 21 CFR Part 11 compliant, then an early iPhone-era mobile engineer and lead: brought PatientKeeper's Mobile Clinical Results to market on iPhone and iPad leading a team of 6, rewrote the WHERE app from scratch, and shipped a highly optimized address book library at CircleBack. As an independent contractor, built Medaxion's anesthesiology billing app and the Harvest Time Tracker.",
    ),
  )),
  education: education,
  full: false,
)
