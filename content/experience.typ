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

#let jobs = (
  (
    role: "Principal Engineer",
    company: "BuildOps",
    location: "Remote",
    start: "Dec 2025",
    end: "Jun 2026",
    lead: "Trusted technical advisor to the VPE, with influence across a 150-person engineering organization.",
    highlights: (
      "Designed, prototyped, and oversaw the implementation of an event capture system for inventory data that previously lacked a source of truth and required hundreds of person-hours to reconcile. The system provides enforcement mechanisms against bypass, fully automated reconciliation, and drove data errors to zero.",
      "Created a program for chronically under-owned services that rebuilt institutional knowledge, cut incident remediation times, and surfaced previously hidden work so staffing and product planning reflect reality.",
      "Eliminated an entire class of database migration outages and contained recurring Kafka consumer failures to minor incidents by leading continuous incident analysis and implementing root-cause-level fixes, including improved Kafka consumer monitoring.",
    ),
  ),
  (
    role: "Founder & Fractional Principal",
    company: "Independent",
    location: "New York, NY",
    start: "Mar 2025",
    end: "Dec 2025",
    lead: "Founded The Therapy Homework App: designed and built a platform to help therapists assign and clients complete homework assignments. Product taken through beta and initial public pilot program.",
    highlights: (
      "Principal at withforward.com; technical screening of candidates and consulting with clients to help shape their engagement.",
      "Engineer at Koodos Labs; designed and implemented a friend-finding system leveraging a hybrid storage system for fast graph lookups without requiring the entire social graph to be held in memory.",
    ),
  ),
  (
    role: "Lead Engineer",
    company: "Capital One",
    location: "New York, NY",
    start: "Jan 2022",
    end: "Mar 2025",
    lead: "Principal consulting engineer for 11 teams spanning core banking and security verticals; relied on for deep expertise and mentorship in distributed systems observability, monitoring, performance tuning, and data correctness.",
    highlights: (
      "Championed, designed, and helped to implement distributed tracing across a high-volume banking system with services including Python AWS Lambda, Scala/ZIO, and Go. Wrote custom enhancements to OTel agents for ZIO and Go.",
      "Identified and eliminated $10k+/month compute waste in a security and compliance-focused data ingestion platform. Proposed, validated, and helped implement new Kafka consumer partition assignment strategies that took minimum and average consumer utilization from as low as 0% to 100% of target.",
    ),
  ),
  (
    role: "Principal Engineer",
    company: "Namely",
    location: "New York, NY",
    start: "Oct 2020",
    end: "Dec 2021",
    lead: "Technical direction across the organization through embedding with teams, digging deep into under-maintained systems, working on high-leverage projects, and mentoring senior+ developers.",
    highlights: (
      "Developed a new technical strategy that helped restore developer velocity, shipping 2.5x more major features/engineer in a 6 month period, and improved reliability, with 53% fewer customers impacted by production incidents year over year.",
      "Took ownership of, and greatly extended a Node.js GraphQL - gRPC gateway in order to dramatically accelerate frontend development.",
      "Built integration test harnesses for key systems in JavaScript and Ruby, and worked with engineers to add integration testing into the development process, helping teams identify compatibility issues during development, rather than in production.",
      "Deep dive into Kubernetes cluster health working closely with staff engineers in SRE and Product Engineering to identify latency issues causing customer-facing slowness and preventing reliable response-time-based alerting.",
    ),
  ),
  (
    role: "CTO",
    company: "SquareFoot",
    location: "New York, NY",
    start: "Jun 2016",
    end: "Oct 2020",
    lead: "Initially brought on to build the company's first iOS app, after completing the first release I was invited to take over the engineering department based on my rapid understanding of the team function, the backend codebase, and company direction. In the years following I built the engineering organization to three high performing teams, created a QA department and opened a successful Engineering office in Belfast, all while remaining hands-on.",
  ),
  (
    role: "Director of Engineering",
    company: "ShopKeep POS",
    location: "New York, NY",
    start: "Jul 2013",
    end: "May 2016",
    lead: "Progressing from IC, to Mobile Lead, to Director of Mobile, and ultimately Director of Engineering in NYC. Helped to grow engineering from 15 to 60 developers and QA engineers. Championed an initiative across QA, Product, Engineering, and Data Science to dramatically reduce mission-critical field-found errors in customer registers.",
  ),
  (
    heading: "Earlier Career — 2002 - 2013",
    lead: "Early iPhone-era mobile engineer and lead: brought PatientKeeper's Mobile Clinical Results to market on iPhone and iPad leading a team of 6, rewrote the WHERE app from scratch, and shipped a highly optimized address book library at CircleBack that dropped into existing apps. As an independent contractor, built the Harvest Time Tracker, an Oxford dictionary app, and Medaxion's anesthesiology billing app. Before mobile: healthcare and clinical trial systems in Java (21 CFR Part 11 compliant), plus an approximate-matching search engine for audio clips.",
  ),
)
