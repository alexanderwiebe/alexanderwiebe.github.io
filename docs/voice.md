# Voice — draft copy

Stage 3 deliverable. Draft prose for Home, About, the four Projects
summaries, the Reading Companions intro, and the Research intro. Every
sentence below was checked against: *does this help the reader
understand AJ?* Cut candidates are marked, not silently kept.

No design decisions here — layout, type, color are Stage 4.

---

## Home

```
AJ WIEBE

Software Engineer. Principal Consultant.

I started as a researcher, studying ontologies and industrial AI.
Then I spent over a decade building software — first my own, then
helping other developers, then teams, then departments.

I still write code and read papers.

Writing   Projects   Research   About
```

Recent Writing / Projects teasers pull live from content — no separate
copy to draft, just the one-line descriptions below for the Projects
teaser.

---

## About

```
I write software, lead the people who write it, and study why
ontologies and knowledge representation still matter to both.

RESEARCHER

I started in research, not industry. At the University of Regina I
worked on industrial applications of AI — ontologies, knowledge
engineering, software generated from a formal model of a problem and
a formal model of the software meant to solve it. That became my
thesis, Ontology Driven Software Engineering Generator, and two
conference papers along the way.

Before the thesis: early jobs at SaskTel and the Canadian federal
government, building geospatial tools and rich internet applications.
Less relevant to what I do now, but it's where I learned to actually
ship something.

DEVELOPER

After the thesis, I spent over a decade writing software client-side —
iQmetrix and HP Enterprise Services first, then eight years at Solvera
Solutions, where I went from developer to team lead to a seat on the
Application Development Council, interviewing the next generation of
developers.

The scope kept expanding. First my own code. Then reviewing someone
else's. Then setting the direction a whole team built in.

TECHNICAL LEADER

Since 2022 I've led Bitovi's engagement with a Fortune 500 financial
services company — architecture, staffing, delivery, and technical
leadership across the account. I started as its only consultant. I
still write code.

Architecture stopped being a technical question and became an
organizational one: how do you get developers you'll never personally
meet to build things the same way.

RESEARCHER, AGAIN

Modern AI reopened the questions I started with. Neurosymbolic AI,
knowledge graphs, AI agents — these are the same problems from my
thesis, with better tools than I had in 2016. I'm not affiliated with
a university. This is independent research, done the way I do
everything else: build something, see what breaks, write it down.

See Research for what that looks like right now, and Projects for what
I'm building alongside it.
```

Cut candidate, left out: any line naming the client or citing scale
(revenue, headcount, project counts). Per the privacy boundary — not a
voice decision, a hard rule.

---

## Projects

### Research Knowledge Graph

```
# Research Knowledge Graph

A personal, plugin-first knowledge graph for academic research — not
owned by any single vendor.

## Why

Every research tool I've used — reference managers, note apps, AI
assistants — wants to own the graph. I wanted the graph to outlast
all of them.

## How it works

The core defines capability contracts — a Research Library Connector,
a Knowledge Store, a Scholarly Metadata Provider — and never talks to
a specific product. Plugins implement the contracts. Swap a vendor,
keep the graph.

## What I learned

Still in design — nothing shipped yet. The hard part isn't the graph
itself, it's writing contracts stable enough that a plugin written in
year one still works in year five.

## Code

https://github.com/alexanderwiebe/research-knowledge-graph
```

### AI Briefing

```
# AI Briefing

Twitter/X, filtered down to what actually matters, delivered to
Telegram twice a day.

## Why

I was spending more time scrolling than learning. I wanted a system
that reads everything so I don't have to, and only surfaces what's
worth acting on.

## How it works

Curated X lists feed through RSSHub, get deduplicated semantically,
then get classified by Claude CLI into four buckets — act now, queue,
inform, skip — weighted by a rolling 30-day credibility score per
source. A weekly agent maps connections between the notes I save.
Runs locally: Python, Redis, SQLite, Docker.

## What I learned

Four categories was the right number. Three collapses "important" into
"urgent." Five is more than I'll ever triage consistently.

## Code

https://github.com/alexanderwiebe/ai-briefing
```

### aj-starter-gold

```
# aj-starter-gold

An Angular + NestJS starter demonstrating basic three-layer
architecture for a demo project.

## Why

I wanted a working reference for the pattern I actually reach for —
presentation, business logic, data — small enough to stand up for a
demo or a teaching moment without re-explaining the architecture from
a blank repo every time.

## How it works

Angular on the frontend, NestJS on the backend, with the three layers
kept visibly separate rather than folded together for convenience.

## What I learned

[DRAFT, confirm or replace — this is my inference, not your words:
a demo doesn't need much scaffolding to make the architecture legible;
past a certain point, more scaffolding makes the demo about the
scaffolding instead of the pattern.]

## Code

https://github.com/alexanderwiebe/aj-starter-gold
```

### This Site

```
# This Site

Built from a written product spec, in stages, with an AI pair — the
same discipline I'd want on a client engagement.

## Why

Most personal sites get designed first and filled with words after.
I wanted the reverse: a spec, then discovery, then structure, then
voice, then design — each stage a doc, reviewed before the next one
started.

## How it works

Discovery was pulled from actual GitHub activity and LinkedIn, not
assumed. Each stage produced a document before any code: discovery.md,
ia.md, this page's copy. All of them are linked below, unedited from
the working versions.

## What I learned

[PLACEHOLDER — write once implementation is further along. Don't
pre-write a retrospective on a build that isn't finished.]

## Code

github.com/alexanderwiebe/alexanderwiebe.github.io — repo keeps its
name; the site is reachable at systemsbyaj.com via custom domain and
(hosting setup pending, see discovery.md) possibly still at the
default GitHub Pages URL.

docs/discovery.md · docs/ia.md · docs/voice.md
```

---

## Reading Companions (intro blurb, not a full project page)

```
READING COMPANIONS

As I read a book or paper, I build the companion repo alongside it —
worked examples, runnable explanation. This is proof I understood the
material, not a claim that I did.

Learning From Data
  Notebook companion for the book.
  → github.com/alexanderwiebe/learning-from-data
```

---

## Research (intro + structure)

```
# Research

My thesis asked how to generate software from a formal model of a
problem domain and a formal model of the software meant to solve it.
A decade in industry answered part of that empirically. Modern AI
reopened the theoretical half — that's where my independent research
time goes now, without a university behind it.

PUBLISHED RESEARCH

2011  SEKE   Knowledge engineering for the domain of carbon dioxide
             capture process system — Zhou, Wiebe, Chan
2012  CCECE  Ontology driven software engineering — Wiebe, Chan
2016  MASc   Ontology Driven Software Engineering Generator
             University of Regina · [link to oURspace]

NOW — independent research, no academic affiliation implied

Neurosymbolic AI
Knowledge representation and knowledge graphs
AI-assisted software engineering
Research agents
```

---

## Resolved (2026-09-12)

1. ~~`aj-starter-gold` Why/How~~ — filled in above from AJ's
   description. "What I learned" is still a draft inference, not his
   words — confirm or replace.
2. ~~This Site's repo~~ — stays `alexanderwiebe.github.io`, no rename.
   Domain hosting itself (single canonical vs. genuinely dual-hosted)
   is a Stage 5 decision — see discovery.md.

## Open items before Stage 4 (design)

1. Confirm or rewrite the `aj-starter-gold` "What I learned" line —
   it's my draft, not a fact.
2. "What I learned" for This Site stays unwritten until the build is
   further along.
