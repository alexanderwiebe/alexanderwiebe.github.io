# Discovery — systemsbyaj.com

Stage 1 of the build process. Source data: GitHub public API for
`alexanderwiebe` (18 non-fork repos, fetched 2026-09-12), the existing
repo content, and the product brief.

## Repo reality check

This repository (`alexanderwiebe/alexanderwiebe.github.io`) is currently
a generic Python/Jupyter/Quarto devcontainer template, not the site.
Decision (confirmed with AJ): keep Quarto as the framework rather than
replacing it with Astro/MDX, specifically so posts can be executable
notebooks — code, data, and figures inline, not prose describing code
after the fact. This is a stronger fit for "technical paper + engineer's
notebook" than a conventional MDX blog would have been.

Domain: `systemsbyaj.com` (not the default `.github.io` domain). Needs:
`CNAME` file at repo root, DNS records at the registrar, canonical URLs
and OpenGraph base URL set to `systemsbyaj.com` throughout.

**Dual-domain hosting (decided 2026-09-12, mechanism deferred to Stage
5):** AJ wants the site reachable at both `alexanderwiebe.github.io`
and `systemsbyaj.com`. Repo keeps its current name — no rename.
Decided now: all internal navigation uses relative links, so the same
built output works unmodified under either domain. Not yet decided:
the actual hosting mechanism, because GitHub Pages' default behavior
works against the goal — once a `CNAME` file is present, GitHub Pages
automatically redirects the `.github.io` URL to the custom domain
(there's no setting to keep both simultaneously live through a single
Pages deploy). Real options for Stage 5, not decided yet:
  a. Accept the redirect — one canonical site at `systemsbyaj.com`,
     old links to the `.github.io` URL still resolve, just forwarded.
     Simplest, standard, best for SEO (no duplicate-content issue).
  b. Skip the GitHub Pages custom-domain config; point `systemsbyaj.com`
     DNS at a separate static host (or a second deploy target from the
     same build) instead, so both URLs serve content independently
     without a redirect. Needs a `rel=canonical` strategy to avoid a
     duplicate-content SEO penalty across two indexable domains.
Relative links (already decided) keep both options open — revisit the
hosting mechanism itself in Stage 5.

## Recurring themes across repos

1. **Knowledge graphs / ontologies** — `research-knowledge-graph`
   (plugin-first personal semantic graph for academic research; design
   stage, no code yet). Direct continuation of the master's thesis work.
2. **AI agents / orchestration pipelines** — `ai-briefing` (Twitter list
   → RSSHub → semantic dedup → Claude CLI classification → Telegram,
   with a weekly note-linking agent). Mature, feature-complete, in
   active personal use.
3. **Developer environment / tooling** — `tmux-setup` (Claude Code skill
   generating multi-repo tmux control rooms, v2.0, actively maintained),
   `nvim` (LazyVim config), `base-notebook` (the devcontainer template
   this repo forked from). This is the "how AJ builds things" thread.
4. **Research / reading, not projects** — `ai-reading-curriculum`
   (12-tier AI/ML curriculum: math foundations → landmark papers →
   applied practice), `learning-from-data`, `anthropic-learning`. These
   belong under Research, not Projects — no code artifact to point to.
5. **Self-hosted infra / AI agents** — `docker` (self-hosted Compose
   stacks, including infra for the `ai-briefing` pipeline), and
   `homelab-todo-bot`, a Telegram bot running Claude CLI in
   plan/revise/execute phases with human approval gates. Both verified
   (see "Previously unverified repos" below); neither is on the
   shortlist yet.

Not investigated further: `number-munchers` (no description, low
relevance), forks (`okta-jwt-verifier-js`, `ngx-charts` — not AJ's
work, excluded per brief).

## Verification gaps

Four repos returned no README on `main` or `master` via the public API:
`homelab-todo-bot`, `docker`, `svg-node-editor`, `aj-starter-gold` — all
four turned out to be public with real content, just using `CLAUDE.md`
instead of `README.md` (or, for `aj-starter-gold`, confirmed directly by
AJ). See "Previously unverified repos — resolved" and the shortlist
above for what each turned out to be.

`aj-agentic-aware` has a README but it's template placeholder text
only ("[Add setup instructions here]") — not presentable.

## Likely audience

Per the brief: a technically sophisticated stranger — likely another
engineer, a potential client/employer doing due diligence, or someone
who found a piece of writing and wants to know who wrote it. Not a
recruiter skimming for keywords.

## Candidate project shortlist (confirmed with AJ 2026-09-12)

1. **Research Knowledge Graph** — ontologies/knowledge graphs, ties
   directly to the thesis. Framed honestly as design-stage, not shipped.
   https://github.com/alexanderwiebe/research-knowledge-graph
2. **AI Briefing** — the strongest "what I'm actually building" entry.
   Real architecture, real tradeoffs (four-quadrant triage model,
   credibility tracking), currently running.
3. **aj-starter-gold** (Angular/NestJS starter kit) — swapped in for
   tmux-setup per AJ. A type-safe, isomorphic TypeScript starter
   combining Angular and NestJS into one three-tier architecture with
   shared types across client and server; the real lesson is that the
   hard part is configuration (build tooling, module boundaries), not
   code. Public and confirmed: https://github.com/alexanderwiebe/aj-starter-gold
4. **This site** — spec-first (the product brief), staged build
   (discovery → IA → voice → design → implementation, each committed
   separately), built with an AI pair rather than ad hoc. The feature
   AJ specifically asked to include: the site's own build process as
   evidence of how he works, not just what he says about it.
   `docs/discovery.md` and `docs/ia.md` will be linked publicly from
   this project's page (confirmed — not staying internal).

## Reading companions (new content pattern, confirmed 2026-09-12)

Distinct from the shortlist above: as AJ reads a book or paper, he
builds a companion repo of worked examples and explanation — proof of
comprehension, not a résumé-padding claim. First confirmed entry:
`learning-from-data` (notebook companion for *Learning From Data*).
https://github.com/alexanderwiebe/learning-from-data

`anthropic-learning` confirmed as the second entry (AJ, 2026-09-12).
https://github.com/alexanderwiebe/anthropic-learning

This pattern is the strongest practical payoff of the Quarto decision:
these are naturally executable-notebook posts, which is exactly what
Quarto was chosen for. See `docs/ia.md` for how this surfaces on the
Projects page (a separate, growing list — not folded into the 4-item
shortlist, since the genre is different: demonstrating understanding
of someone else's work vs. building an original thing).

## Previously "unverified" repos — resolved 2026-09-12

None of these were actually private — the public README fetch just
missed (wrong assumed filename/branch; all three use `CLAUDE.md`
instead of `README.md`, no `README.md` at all). Verified via GitHub API
+ raw `CLAUDE.md`. None are on the project shortlist (still 4 items,
confirmed) — these are findings to report, not additions to make
unilaterally:

- **`docker`** — self-hosted Docker Compose stacks (`core`, `otel`,
  `zotero-ingest`). The `core` stack's architecture diagram documents
  data flow into the `ai-briefing` pipeline, and `zotero-ingest`
  plausibly feeds the Research Knowledge Graph (Zotero is a reference
  manager). Infra supporting two shortlisted projects, not a project
  in its own right — worth a mention inside AI Briefing's page if AJ
  wants, not a 5th Projects entry.
- **`homelab-todo-bot`** — a real, well-defined AI agent project: a
  Telegram bot managing homelab tasks stored in an Obsidian vault,
  using the Claude CLI in plan/revise/execute phases with a human
  approval gate before any action executes. Genuinely fits the "AI
  agents" theme as well as AI Briefing does. Candidate for a future
  5th project if AJ wants to expand the shortlist — not added without
  his say-so.
  https://github.com/alexanderwiebe/homelab-todo-bot
- **`svg-node-editor`** — actually named "AI Document": an AI-powered
  document editor monorepo, Angular 21 + NestJS 11 + Bun workspaces,
  DDD frontend with NgRx SignalStore. My earlier guess ("graph
  visualization tool," from the repo name alone) was wrong — exactly
  why the brief says not to write descriptions from names. Thematically
  close to aj-starter-gold (same Angular+NestJS pattern, more fully
  realized) — also a candidate for later, not added now.
  https://github.com/alexanderwiebe/svg-node-editor

## Career timeline (public, LinkedIn-sourced — safe to quote/reuse)

AJ supplied the LinkedIn Experience section directly (screenshot,
2026-09-12) after automated fetch was blocked. Already written in
first person, already anonymizes the current client itself — this is
usable source material for About/Resume voice, not just a timeline:

- **Bitovi** (Apr 2023–present, Principal Consultant; Jan 2022–Apr 2023,
  Developer Consultant/Angular Delivery Lead) — "I lead Bitovi's
  engagement with a Fortune 500 financial services company... I build
  teams, fix delivery problems, and work through technical leads to
  change how software gets built. I still write code."
- **Solvera Solutions** (Oct 2013–Jan 2022, 8 yrs 4 mos, Saskatchewan)
  — developer → team lead → Application Development Council member.
- **Researcher, University of Regina** (May 2010–Apr 2016) — "industrial
  applications of artificial intelligence, focusing on ontologies and
  software engineering," leading to the thesis and two conference
  papers (see Publications above — these are now independently
  verified, not just self-reported).
- **HP Enterprise Services** (Jun 2012–Oct 2013) — SharePoint Farm
  development, SharePoint 2007→2010 upgrade.
- **iQmetrix** (Apr 2011–Jun 2012) — internal systems, web portal.
- **SaskTel** (Technical Assistant/Researcher, May–Aug 2009; Tech
  Assistant/Lab Manager, Sep–Dec 2008) — early Flash/Java/MySQL RIA
  work, server virtualization.
- **Canadian Federal Government** (Jan–Apr 2007) — geospatial tooling
  for the National Land and Water Information System, C++/ArcGIS, Java.

Note: the resume lists "Information Services Corporation — HP" for
2011–2013 where LinkedIn splits this into iQmetrix (2011–2012) and HP
Enterprise Services (2012–2013). Immaterial for the site — LinkedIn's
version is the public-facing one and is what the site should follow.

This confirms the pre-2010 timeline goes back further than the brief's
"Core story" implies (SaskTel, federal government, geospatial/RIA work
starting 2007) — optional context for About, not required.

## Content gaps

- Career timeline: resolved above. Still open: the LinkedIn "About"
  summary/headline blurb and any posts/articles, if AJ wants to seed
  Writing or About from them — not required to proceed to Stage 2.
- Private résumé reviewed directly (PDF, 2026 version) for career
  timeline and thesis/publication details only. It names the actual
  client and employer (Bitovi), plus specific figures (revenue growth,
  consultant headcount, project/dev counts, component counts). **None
  of this goes on the public site — including the client's name itself,
  deliberately not repeated in this document.** The boundary holds
  exactly as the brief states: "Fortune 500 financial services
  company," no name, no metrics.
- Career timeline extracted from the resume (safe, structural facts
  only — titles and date ranges, no client names) confirms the brief's
  "Core story" arc almost exactly:
  - 2010–2016: researcher, industrial applications of AI / ontology-based
    software (concurrent with BASc 2010, MASc Jan 2016)
  - 2013–2017: individual developer roles (increasing scope: internal
    tools → client systems → integration work)
  - 2017–2022: team lead (delivery + mentoring scope)
  - 2022–present: principal consultant / engagement lead (organizational
    scope) — publicly: "Fortune 500 financial services company"
  This is real evidence for the About page's stage progression, not
  invented narrative.
- Publications verified directly (not from the resume's abbreviated
  citations) — real, linkable, no fabrication needed:
  - Thesis: *Ontology Driven Software Engineering Generator*, MASc,
    University of Regina, Jan 2016.
    https://ourspace.uregina.ca/handle/10294/6832
  - A.J. Wiebe, C.W. Chan, "Ontology driven software engineering,"
    IEEE CCECE 2012, pp. 1–4.
    https://ieeexplore.ieee.org/document/6334938
  - Zhou, A.J. Wiebe, C.W. Chan, "Knowledge engineering for the domain
    of carbon dioxide capture process system," SEKE 2011, pp. 414–419
    (Miami Beach, July 2011).
- `/resume` still needs to be authored from LinkedIn-safe information
  per the brief, not copied from the private document.

## Privacy/confidentiality boundary

Per CLAUDE.md and the brief: current engagement described only as
"Fortune 500 financial services company," no client name, no
engagement metrics (team size, project count, commercial figures).
The private résumé exists now (reviewed above) and does contain exactly
the information the brief warns against — the boundary is load-bearing,
not theoretical. Any About/Projects/Research copy drafted from resume
context must be re-checked against this boundary before publishing.

## Recommended site structure

Unchanged from the brief:

```
/
├── /
├── /about
├── /writing/[slug]
├── /projects/[slug]
├── /research
└── /resume
```

## Open decisions for AJ before Stage 2 (IA)

1. ~~Confirm or revise the project shortlist.~~ Done — see above.
2. ~~Resolve the private-repos list.~~ Done — none were private; see
   "Previously unverified repos — resolved" above. `homelab-todo-bot`
   and `svg-node-editor` are candidates for a future shortlist
   expansion, not added without AJ's say-so.
3. ~~Career timeline.~~ Done — LinkedIn Experience section supplied.
   Optional, not blocking: LinkedIn About blurb / posts, if any should
   seed Writing.
4. ~~Publication links.~~ Done — verified independently, no LinkedIn
   needed.

Nothing left blocks Stage 2 (information architecture). Items 2 and 3
above can resolve in parallel with IA work rather than gating it.
