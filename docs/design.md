# Design system — systemsbyaj.com

Stage 4 deliverable. Built around the content already drafted in
`voice.md`, not the other way around — no empty boxes invented first.
"Technical paper + engineer's notebook + source code," not "executive
portfolio + SaaS landing page."

## Typography

Two families, used consistently by role — never mixed within the same
kind of content.

- **Serif** — for the name, headings, body prose, dek/intro lines.
  Reading typeface. (`Source Serif 4` or `Lora`, system serif fallback:
  `Georgia, "Iowan Old Style", serif`.)
- **Monospace** — for metadata: dates, labels, section tags, nav, code,
  repo links, project status. Never for body prose.
  (`JetBrains Mono` or `IBM Plex Mono`, fallback: `ui-monospace, "SF
  Mono", Consolas, monospace`.)

Type scale (rem, mobile-first, scale up slightly on wide viewports):

| Role | Family | Size | Notes |
|---|---|---|---|
| Name / H1 | Serif | 2.25–2.75 | Normal weight, not bold-heavy |
| Section label | Mono | 0.75, uppercase, `letter-spacing: 0.08em` | "PROJECTS", "NOW", "PUBLISHED RESEARCH" |
| H2 (page section) | Serif | 1.375 | |
| Body | Serif | 1.0625 | line-height 1.7 |
| Meta (dates, type tags) | Mono | 0.8125, muted color | |
| Nav | Mono | 0.8125, uppercase | |

## Color

Two full palettes, light-first, dark redefining only tokens.

```
Light
  --bg:        #FAFAF7   (warm paper, not pure white)
  --ink:       #1A1A18
  --ink-muted: #5B5B54
  --rule:      #D8D5CC   (dotted/solid hairlines)
  --accent:    #33553B   (muted ink-green — echoes the resume's
                          green rather than introducing a new brand
                          color)

Dark
  --bg:        #16150F
  --ink:       #EDEAE0
  --ink-muted: #9B978A
  --rule:      #34322A
  --accent:    #6FA37D
```

No gradients. No neon. Accent used sparingly — link hover, section
rule, current-nav-item — never as a background fill.

## Layout

- Single column. Max width ~700px for prose, ~900px for the page shell
  (masthead + nav + content). Diagrams/code blocks may exceed 700px up
  to the shell width, each in its own scroll container if wider still.
- Masthead: name (serif, large), role line underneath (mono, muted),
  a single hairline rule, then nav as a plain mono row — no button
  styling, no active-tab pill.
- Section labels are the only "chrome": uppercase mono tag above a
  list or block, exactly like the resume's `SKILLS` / `HIGHLIGHTS`
  treatment already does. Reuse that convention rather than inventing
  a new one — it's already how AJ's own documents look.
- List rows (Writing index, Projects teaser, Research entries): title
  left, meta (date/type) right or below in mono, thin rule between
  rows. No cards, no shadows, no thumbnails.
- Whitespace does the separating work — rules are thin and rare, not a
  grid of boxes.

## Components

- **Project page**: H1 title (serif) → one-line dek (serif, italic) →
  H2 `Why` / `How it works` / `What I learned` / `Code` (mono label,
  serif body under each) → code link as plain mono text, not a button.
- **Research page**: two mono section labels (`PUBLISHED RESEARCH`,
  `NOW`) — this split must stay visually obvious, it's load-bearing per
  the brief, not incidental.
- **Reading Companions**: a lighter list row style, one line per entry,
  distinct enough from the main Projects list that it doesn't read as
  a fifth project.
- **Diagrams** (where they appear, e.g. AI Briefing's pipeline): inline
  SVG, ink-colored lines and mono labels only, no icons/gradients/glow.

## Explicitly rejected

Hero section, giant portrait, "Learn More" buttons, skill-percentage
bars, animated timeline, testimonial carousel, card-in-card layouts,
stock photography, glowing network nodes, decorative code backgrounds.
(Restated from the brief — Stage 4 is where it'd be easiest to
backslide into these by default, so repeating it here.)

## Responsive

Single column throughout; nav wraps rather than collapsing into a
hamburger (there are only 4 items). Mono type shrinks slightly on
narrow viewports; serif body stays reader-sized down to phone width.

## Next

A visual mockup (canvas, multiple pages) applying this system to the
actual drafted content from `voice.md` — separate from this written
spec, so AJ can react to something seen rather than only described.
