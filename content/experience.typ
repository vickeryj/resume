// Full work history — the single source of truth for every target.
//
// Each job has:
//   role, company, location, start, end   — the heading line
//   summary   — optional one-liner of scope (team size, mandate)
//   highlights — bullets shown on EVERY target (your strongest, most portable wins)
//   more       — extra bullets shown ONLY on the full/CV targets (full: true)
//   recent     — set to false to drop a job from the condensed résumés;
//                omit (defaults true) to always include it
//
// Write highlights role-neutrally where you can; the target files supply the
// role-specific framing via the summary. Replace all of this with your real
// history — it's placeholder scaffolding.

#let jobs = (
  (
    role: "Principal Engineer",
    company: "Example Corp",
    location: "Remote",
    start: "2021",
    end: "Present",
    summary: "Technical lead for a 40-engineer platform org spanning 6 teams.",
    highlights: (
      "Set multi-year technical direction for the core platform, aligning architecture with company strategy across product lines.",
      "Led the migration to a service-based architecture, cutting median deploy time from hours to minutes and improving reliability to 99.95%.",
      "Established engineering standards, review practices, and an RFC process now used company-wide.",
    ),
    more: (
      "Mentored 8 senior and staff engineers, three of whom were promoted to staff+ under my guidance.",
      "Drove a cross-org observability initiative, reducing mean-time-to-resolution on Sev-1 incidents by 60%.",
      "Partnered with product and design leadership to define the technical roadmap for two major product launches.",
    ),
  ),
  (
    role: "Staff Software Engineer",
    company: "Growth Startup Inc.",
    location: "City, State",
    start: "2017",
    end: "2021",
    summary: "Founding-era engineer; scaled the system from 10k to 5M users.",
    highlights: (
      "Architected the data pipeline and API layer that supported 100x growth without a re-platform.",
      "Built and led a team of 6 engineers, owning hiring, roadmap, and delivery for the payments domain.",
    ),
    more: (
      "Introduced automated testing and CI, taking the team from weekly manual releases to continuous deployment.",
      "Designed the multi-tenant permissions model still in use across the product.",
    ),
  ),
  (
    role: "Senior Software Engineer",
    company: "Midsize Software Co.",
    location: "City, State",
    start: "2013",
    end: "2017",
    highlights: (
      "Owned the billing and subscription systems processing $XXM in annual revenue.",
    ),
    more: (
      "Rewrote the legacy reporting engine, cutting report generation time by 90%.",
    ),
    recent: false,
  ),
  (
    role: "Software Engineer",
    company: "First Job LLC",
    location: "City, State",
    start: "2010",
    end: "2013",
    highlights: (
      "Delivered features across the full stack for a B2B SaaS product.",
    ),
    more: (
      "Built the company's first automated deployment pipeline.",
    ),
    recent: false,
  ),
)
