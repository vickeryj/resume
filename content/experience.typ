// Full work history — the single source of truth for every target.
//
// Each job has:
//   role, company, location, start, end   — assembled into the all-caps heading,
//     e.g. "PRINCIPAL ENGINEER, BUILDOPS; REMOTE — DEC 2025 - JUN 2026".
//     (Or set `heading:` to override the whole line, as with "Earlier Career".)
//   lead        — the paragraph under the heading
//   highlights  — bullets shown on EVERY target
//   more        — extra bullets shown ONLY on the full/CV targets (full: true)
//   recent      — set to false to drop a job from the condensed résumés;
//                 omit (defaults true) to always include it
//   targets     — restrict the job to some target tags, e.g. ("vpe",)
//
// Any field or bullet may be wrapped in `variant(pe: …, vpe: …)` to differ per
// target; see lib/variants.typ. Tags in use: "pe" (Principal Engineer) and
// "vpe" (VP of Engineering). The VPE angle emphasizes org-building, management,
// and AI adoption; the PE angle emphasizes depth of IC work.

#import "../lib/variants.typ": variant, resolve-jobs
#import "older_experience.typ": older-jobs

#let jobs = (
  (
    role: "Principal Engineer",
    company: "BuildOps",
    location: "Remote",
    start: "Dec 2025",
    end: "Jun 2026",
    lead: "Trusted technical advisor to the VPE, with influence across a 150-person engineering organization.",
    highlights: (
      
      variant(
        pe: ("Designed, prototyped, and oversaw the implementation of an event capture system for inventory data that previously lacked a source of truth and required hundreds of person-hours to reconcile. The system provides enforcement mechanisms against bypass, fully automated reconciliation, and drove data errors to zero.",
        "Drove pragmatic AI adoption across the org: coached developers on efficient use of AI coding (including token-efficient workflows), and built deterministic CI checks to complement AI code review — routing mechanical feedback to fast, cheap, consistent tooling and reserving high-cost, non-deterministic analysis for the problems that actually require it.",
        "Eliminated an entire class of database migration outages and contained recurring Kafka consumer failures to minor incidents by leading continuous incident analysis and implementing root-cause-level fixes, including predictive Kafka consumer monitoring.",
        ),
        vpe: ("Founded the FinancialOS Engineering team: designed, prototyped, and oversaw the implementation of an event capture system for inventory data that previously lacked a source of truth and required hundreds of person-hours to reconcile. The system provides enforcement mechanisms against bypass, fully automated reconciliation, and drove data errors to zero.",
        "Created a program for chronically under-owned services that rebuilt institutional knowledge, cut incident remediation times, and surfaced previously hidden work so staffing and product planning reflect reality.",
        "Eliminated an entire class of database migration outages and contained recurring Kafka consumer failures to minor incidents by leading continuous incident analysis and implementing root-cause-level fixes."),
      ),
    ),
  ),
  (
    role: "Founder & Fractional Principal",
    company: "Independent",
    location: "New York, NY",
    start: "Mar 2025",
    end: "Dec 2025",
    // PE tells the founding story as the lead; VPE makes it the first bullet.
    lead: variant(
      pe: "Founded The Therapy Homework App: designed and built a platform to help therapists assign and clients complete homework assignments. Product taken through beta and initial public pilot program.",
    ),
    highlights: (
      variant(
        vpe: "Founded The Therapy Homework App: designed and built a platform to help therapists assign and clients complete homework assignments. Product taken through beta and initial public pilot program.",
      ),
      "Engineer at Koodos Labs; designed and implemented a friend-finding system leveraging a hybrid storage system for fast graph lookups without requiring the entire social graph to be held in memory.",
      "Principal at withforward.com; technical screening of candidates and consulting with clients to help shape their engagement.",
    ),
  ),
  (
    role: "Lead Engineer",
    company: "Capital One",
    location: "New York, NY",
    start: "Jan 2022",
    end: "Mar 2025",
    lead: variant(
      pe: "Principal consulting engineer for 11 teams spanning core banking and security verticals; relied on for deep expertise and mentorship in distributed systems observability, monitoring, performance tuning, and data correctness.",
      vpe: "Principal consulting engineer for 11 teams spanning core banking and security verticals; relied on for deep expertise and mentorship in distributed systems observability, performance tuning, and data correctness.",
    ),
    highlights: (
      "Championed, designed, and helped to implement distributed tracing across a high-volume banking system with services including Python AWS Lambda, Scala/ZIO, and Go. Wrote custom enhancements to OTel agents for ZIO and Go.",
      variant(
        pe: "Identified and eliminated $10k+/month compute waste in a security and compliance-focused data ingestion platform. Proposed, validated, and helped implement new Kafka consumer partition assignment strategies that took minimum and average consumer utilization from as low as 0% to 100% of target.",
        vpe: "Identified and eliminated $10k+/month compute waste in a security and compliance-focused data ingestion platform via new Kafka consumer partition assignment strategies that took minimum consumer utilization from as low as 0% to 100% of target.",
      ),
    ),
  ),
  (
    role: "Principal Engineer",
    company: "Namely",
    location: "New York, NY",
    start: "Oct 2020",
    end: "Dec 2021",
    lead: variant(
      pe: "Technical direction across the organization through embedding with teams, digging deep into under-maintained systems, working on high-leverage projects, and mentoring senior+ developers.",
      vpe: "Technical direction across the organization through embedding with teams, digging deep into under-maintained systems, and mentoring senior+ developers.",
    ),
    highlights: (
      "Developed a new technical strategy that helped restore developer velocity, shipping 2.5x more major features/engineer in a 6 month period, and improved reliability, with 53% fewer customers impacted by production incidents year over year.",
      variant(
        pe: (
          "Took ownership of, and greatly extended a Node.js GraphQL - gRPC gateway in order to dramatically accelerate frontend development.",
          "Built integration test harnesses for key systems in JavaScript and Ruby, and worked with engineers to add integration testing into the development process, helping teams identify compatibility issues during development, rather than in production.",
        ),
      ),
      variant(
        pe: "Deep dive into Kubernetes cluster health working closely with staff engineers in SRE and Product Engineering to identify latency issues causing customer-facing slowness and preventing reliable response-time-based alerting.",
        vpe: "Deep dive into Kubernetes cluster health with staff engineers in SRE and Product Engineering to identify latency issues causing customer-facing slowness and preventing reliable response-time-based alerting.",
      ),
    ),
  ),
  (
    role: "CTO",
    company: "SquareFoot",
    location: "New York, NY",
    start: "Jun 2016",
    end: "Oct 2020",
    lead: "Hired as a staff engineer to build the company's first iOS app; promoted to VP of Engineering, then CTO. Led the department for four years while staying hands-on in the codebase.",
    highlights: variant(
      vpe: (
        "Grew engineering from 4 to 25 engineers across three teams, hiring and developing 3 engineering managers, and building the interview and leveling processes to support the growth.",
        "Opened and scaled a successful engineering office in Belfast — sourcing leadership, establishing hiring pipelines, and integrating a remote team into a NYC-centered engineering culture years before remote was default.",
        "Created the company's QA department from zero: hired its leadership, defined its charter, and integrated it into the development process.",
        "Remained a working engineer throughout — designed and oversaw the replacement of the commercial real estate data ingestion pipeline, and regularly shipped iOS, Rails, and React code — while setting technical direction for the platform.",
      ),
      pe: (
        "Designed, prototyped, and oversaw the replacement of the commercial real estate data ingestion pipeline.",
        "Regularly shipped iOS, Rails, and React code while setting technical direction for the platform.",
      ),
    ),
  ),
  (
    role: "Director of Engineering",
    company: "ShopKeep POS",
    location: "New York, NY",
    start: "Jul 2013",
    end: "May 2016",
    lead: variant(
      pe: "Progressing from IC, to Mobile Lead, to Director of Mobile, and ultimately Director of Engineering in NYC. Helped to grow engineering from 15 to 60 developers and QA engineers. Championed an initiative across QA, Product, Engineering, and Data Science to dramatically reduce mission-critical field-found errors in customer registers.",
      vpe: "Progressed from IC to Mobile Lead, Director of Mobile, and Director of Engineering (NYC) as the org grew from 15 to 60 engineers and QA.",
    ),
    highlights: variant(
      vpe: (
        "As Director, managed 4 engineering managers, owning hiring, development, and delivery for the NYC organization through 4x growth.",
        "Championed a cross-functional initiative spanning QA, Product, Engineering, and Data Science that dramatically reduced mission-critical field-found errors in customer registers.",
      ),
    ),
  ),
)

// Everything before 2013, compressed into one paragraph. The condensed résumés
// end here; the CVs list those roles individually instead (older_experience.typ).
#let earlier-career = (
  heading: "Earlier Career — 2002 - 2013",
  lead: "Early iPhone-era mobile engineer and lead: brought PatientKeeper's Mobile Clinical Results to market on iPhone and iPad leading a team of 6, rewrote the WHERE app from scratch, and shipped a highly optimized address book library at CircleBack that dropped into existing apps. As an independent contractor, built the Harvest Time Tracker, an Oxford dictionary app, and Medaxion's anesthesiology billing app. Before mobile: healthcare and clinical trial systems in Java (21 CFR Part 11 compliant), plus an approximate-matching search engine for audio clips.",
)

// The history resolved for one target tag — this is what targets/*.typ import.
// `full` must match the flag the target passes to render().
//
// `patch` is a hook for one-off targets: a per-job mapper (or an array of them,
// applied in order) run over the raw history before resolution. Keep such
// tweaks in the target file, not here — see lib/overrides.typ.
#let jobs-for(tag, full: false, patch: none) = {
  let tail = if full { older-jobs } else { (earlier-career,) }
  let all = jobs + tail
  if patch != none {
    for step in (if type(patch) == array { patch } else { (patch,) }) {
      all = all.map(step)
    }
  }
  resolve-jobs(all, tag)
}
