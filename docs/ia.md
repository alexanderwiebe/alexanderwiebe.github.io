# Information Architecture — systemsbyaj.com

Stage 2 deliverable. Text-only sitemap and rough page content. No
visual design decisions here — that's Stage 4.

## Sitemap

```
/
├── /about
├── /writing
│   └── /writing/[slug]
├── /projects
│   └── /projects/[slug]
├── /research
└── /resume
```

## Purpose check

| Page | Purpose | Cut if... |
|---|---|---|
| `/` | Answer "who is this" in one screen, surface recent work | it becomes a dashboard |
| `/about` | Explain the thread connecting career stages | it becomes a chronological résumé |
| `/writing` | Show how AJ thinks, in progress, not just finished essays | posts are forced into false polish |
| `/projects` | Show what he builds and why, from real repos | it becomes a portfolio grid |
| `/research` | Separate published research from current independent inquiry | it implies current academic affiliation |
| `/resume` | Public career summary, links to LinkedIn | it duplicates the private résumé |

No page for Contact, Now, Uses, Newsletter, Tags/Categories — none
earn a reason to exist yet. Revisit only if a real need shows up.

## Home

Rough content, not final copy (Stage 3 does voice):

```
AJ WIEBE

Software Engineer. Principal Consultant.

[2-3 sentence version of the researcher → developer → technical
leader → researcher-again arc, from discovery.md]

Writing   Projects   Research   About

────────────────────────

RECENT WRITING
(empty until first post — do not fake placeholder content)

PROJECTS
Research Knowledge Graph
AI Briefing
[Angular/NestJS starter — public name TBD]
This Site
```

Open question: does Home show all 4 shortlisted projects, or a curated
2–3 with "more →"? Lean toward showing all 4 at launch — there's no
volume problem yet.

## About

Structure (not prose yet):

1. Cold open — what AJ does now, one line, no ramp-up.
2. Researcher, 2010–2016 (arguably back to 2007 per LinkedIn — SaskTel,
   federal government geospatial work) — why ontologies, what the
   thesis was, link to it.
3. Developer, 2011–2022 (iQmetrix, HP, Solvera) — how "writing software"
   became "helping other developers write software" (team lead,
   Application Development Council, code review, interviewing).
4. Technical leader, 2022–present (Bitovi) — how architecture became an
   organizational problem. Public boundary: "Fortune 500 financial
   services company," nothing else — the LinkedIn language already
   does this correctly, reuse it.
5. Why modern AI brought him back to research — current interests
   (neurosymbolic AI, ontologies, knowledge graphs, AI agents,
   distributed systems, software delivery) — bridge to /research.

Explicitly not a stage-by-stage job list. The résumé already says what
happened; this page says why it connects.

## Writing

Structure:

```
/writing
  filter or grouping by type (optional, only if volume justifies it):
    Article | Note | Project log | Research note
  reverse-chronological list
  each entry: title, type, date, one-line description

/writing/[slug]
  standalone piece, whatever length the content actually needs
```

Launches empty. Do not backfill with hastily-written posts just to
avoid an empty page — an empty Writing section with a clear premise is
more honest than filler.

## Projects

Four entries, confirmed shortlist from discovery.md, each following the
brief's template (`# Name` / one sentence / Why / How it works / What I
learned / Code):

1. **Research Knowledge Graph** — honest about design-stage status;
   the "why" (avoid vendor lock-in, contract-based plugin architecture)
   is itself the interesting part even with no shipped code yet.
2. **AI Briefing** — has the most real architecture to show (RSS →
   dedup → Claude CLI classification → Telegram, four-quadrant triage).
   Best candidate for an actual diagram.
3. **aj-starter-gold** (Angular/NestJS starter kit) — confirmed public
   name, no rename needed.
   https://github.com/alexanderwiebe/aj-starter-gold
4. **This site** — the meta entry. Why: `docs/discovery.md`, `docs/ia.md`,
   and the later voice/design docs are the "how it works" section,
   linked directly (confirmed public, not internal-only). What I
   learned can be written honestly once the build is further along,
   not before.

Repo link for #1: https://github.com/alexanderwiebe/research-knowledge-graph

### Reading companions — a separate, growing track

Not part of the 4-item shortlist above. Different genre: these repos
exist to demonstrate comprehension of a specific book or paper (worked
examples, runnable explanation), not to solve an original problem. The
distinction matters — mixing them into "Projects" proper would dilute
both: the shortlist stops being "here's what I built" and the reading
practice stops being legible as its own thing.

Confirmed first entry: `learning-from-data` — notebook companion for
*Learning From Data*. https://github.com/alexanderwiebe/learning-from-data

Candidate, unconfirmed: `anthropic-learning` (Jupyter Notebook, no
description in the GitHub API response) — possibly the same pattern
applied to Claude/Anthropic material. Verify before listing.

Format, lighter than the full project template:

```
READING COMPANIONS

Learning From Data — [author]
  What it demonstrates: [one line]
  → github.com/alexanderwiebe/learning-from-data

[grows over time, one line per entry, newest first]
```

This is a direct, structural payoff of keeping Quarto: these are
naturally executable notebooks, not blog posts describing code — the
framework decision and this content pattern reinforce each other.

## Research

```
/research

Published research
  2011  SEKE — "Knowledge engineering for the domain of carbon dioxide
        capture process system" (Zhou, Wiebe, Chan)
  2012  CCECE — "Ontology driven software engineering" (Wiebe, Chan)
  2016  MASc thesis — "Ontology Driven Software Engineering Generator,"
        University of Regina  [link to oURspace]

Now — independent research, no academic affiliation implied
  Neurosymbolic AI
  Knowledge representation / knowledge graphs
  AI-assisted software engineering
  Research agents
```

The "published" / "now" split must stay visually and textually distinct
— this is a repeated instruction in the brief, worth protecting in IA
before it gets blurred in Stage 4 design.

## Resume

```
/resume

Short public career summary, written from LinkedIn-safe information —
not copied from the private résumé.
Link out to linkedin.com/in/softwarebyaj for the full history.
No PDF of the private résumé is published here.
```

## Cross-linking

- Research Knowledge Graph (project) ↔ Research page (current
  interests) — same subject, two different framings (what he's
  building vs. what he's studying). Link both directions.
- About's "why he still writes code" section can link to Projects.
- This-site project page can link to `/docs/discovery.md` and
  `/docs/ia.md` directly if they end up committed into the public repo
  (they're currently just repo docs — confirm before Stage 5 whether
  these become public-facing pages or stay internal build artifacts).

## Resolved (2026-09-12)

1. ~~Public name for the Angular/NestJS starter~~ — `aj-starter-gold`,
   already public.
2. ~~Home: all 4 projects or curated subset~~ — all 4.
3. ~~docs/ files linked publicly or internal~~ — linked publicly from
   the "This site" project page.

## Open items (non-blocking)

1. Verify `anthropic-learning` as a second reading-companion entry.
