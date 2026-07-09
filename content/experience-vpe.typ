// Work history angled for VP of Engineering targets.
//
// Same shape as experience.typ (see its doc comment for the field reference),
// but leads and bullets emphasize org-building, management, and AI adoption
// over deep IC work. Source: resume-vpe.md.

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
      "Drove pragmatic AI adoption across the org: coached developers on efficient use of AI coding tools (including token-efficient workflows), and built deterministic CI checks to complement AI code review — routing mechanical feedback to fast, cheap, consistent tooling and reserving high-cost, non-deterministic analysis for the problems that actually require it.",
      "Eliminated an entire class of database migration outages and contained recurring Kafka consumer failures to minor incidents by leading continuous incident analysis and implementing root-cause-level fixes.",
    ),
  ),
  (
    role: "Founder & Fractional Principal",
    company: "Independent",
    location: "New York, NY",
    start: "Mar 2025",
    end: "Dec 2025",
    highlights: (
      "Founded The Therapy Homework App: designed and built a platform to help therapists assign and clients complete homework assignments. Product taken through beta and initial public pilot program.",
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
    lead: "Principal consulting engineer for 11 teams spanning core banking and security verticals; relied on for deep expertise and mentorship in distributed systems observability, performance tuning, and data correctness.",
    highlights: (
      "Championed, designed, and helped to implement distributed tracing across a high-volume banking system with services including Python AWS Lambda, Scala/ZIO, and Go. Wrote custom enhancements to OTel agents for ZIO and Go.",
      "Identified and eliminated $10k+/month compute waste in a security and compliance-focused data ingestion platform via new Kafka consumer partition assignment strategies that took minimum consumer utilization from as low as 0% to 100% of target.",
    ),
  ),
  (
    role: "Principal Engineer",
    company: "Namely",
    location: "New York, NY",
    start: "Oct 2020",
    end: "Dec 2021",
    lead: "Technical direction across the organization through embedding with teams, digging deep into under-maintained systems, and mentoring senior+ developers.",
    highlights: (
      "Developed a new technical strategy that helped restore developer velocity, shipping 2.5x more major features/engineer in a 6 month period, and improved reliability, with 53% fewer customers impacted by production incidents year over year.",
      "Deep dive into Kubernetes cluster health with staff engineers in SRE and Product Engineering to identify latency issues causing customer-facing slowness and preventing reliable response-time-based alerting.",
    ),
  ),
  (
    role: "CTO",
    company: "SquareFoot",
    location: "New York, NY",
    start: "Jun 2016",
    end: "Oct 2020",
    lead: "Joined to build the company's first iOS app; invited to take over engineering after the first release. Led the department for four years while staying hands-on in the codebase.",
    highlights: (
      "Grew engineering from 4 to 25 engineers across three teams, hiring and developing 3 engineering managers, and building the interview and leveling processes to support the growth.",
      "Opened and scaled a successful engineering office in Belfast — sourcing leadership, establishing hiring pipelines, and integrating a remote team into a NYC-centered engineering culture years before remote was default.",
      "Created the company's QA department from zero: hired its leadership, defined its charter, and integrated it into the development process.",
      "Remained a working engineer throughout — designed and oversaw the replacement of the commercial real estate data ingestion pipeline, and regularly shipped iOS, Rails, and React code — while setting technical direction for the platform.",
    ),
  ),
  (
    role: "Director of Engineering",
    company: "ShopKeep POS",
    location: "New York, NY",
    start: "Jul 2013",
    end: "May 2016",
    lead: "Progressed from IC to Mobile Lead, Director of Mobile, and Director of Engineering (NYC) as the org grew from 15 to 60 engineers and QA.",
    highlights: (
      "As Director, managed 4 engineering managers, owning hiring, development, and delivery for the NYC organization through 4x growth.",
      "Championed a cross-functional initiative spanning QA, Product, Engineering, and Data Science that dramatically reduced mission-critical field-found errors in customer registers.",
    ),
  ),
  (
    heading: "Earlier Career — 2002 - 2013",
    lead: "Early iPhone-era mobile engineer and lead: brought PatientKeeper's Mobile Clinical Results to market on iPhone and iPad leading a team of 6, rewrote the WHERE app from scratch, and shipped a highly optimized address book library at CircleBack that dropped into existing apps. As an independent contractor, built the Harvest Time Tracker, an Oxford dictionary app, and Medaxion's anesthesiology billing app. Before mobile: healthcare and clinical trial systems in Java (21 CFR Part 11 compliant), plus an approximate-matching search engine for audio clips.",
  ),
)

// Skills line for VPE targets: leadership-adjacent ordering, adds AI-assisted
// SDLC, drops Scala.
#let skills = (
  "TypeScript", "Swift", "Python", "Go", "Ruby",
  "Kafka", "DynamoDB", "AWS", "OTel", "AI-assisted SDLC",
)
