# Agent-readable blog posts

Each post under `writing/` has two audiences:

- **Readers** get the post: plain Markdown, written for people.
- **Agents** get WebMCP tools that answer the questions readers ask of any post: what is it,
  is it for me, can I trust it, what does it claim and on what evidence, how does it fit with
  other work, what do I do next. The answers come from the post's `agent:` frontmatter.

Both are built from the one `.qmd` file, so they can't drift apart.

## Writing a post

Create `writing/<slug>/index.qmd`. Images and downloads for the post go in the same folder.

```yaml
---
title: "We cut CI time 60% by dropping Docker layer caching"
description: "One-line description, shown under the title and in the writing list."
date: 2026-11-04
date-modified: 2026-11-04   # optional
draft: true                 # optional; drafts are not published or listed

agent:
  summary: "The thesis in one sentence."
  takeaways:
    - "What a reader should remember."
  audience:
    for: ["Platform engineers", "Teams whose CI takes over 20 minutes"]
    not_for: ["Monorepos built with Bazel"]
    prerequisites: ["GitHub Actions", "Basic Docker"]
  author_experience: "What AJ has done hands-on that this post draws on."
  tested_against: { github_actions: "2026-09", docker: "27.x" }
  outdated: []              # sections AJ knows no longer hold
  disclosures: []           # sponsorships, affiliate links, products sold
  claims:
    - id: c1
      claim: "Layer caching added about 4 minutes per run on cold runners."
      evidence: { type: measured, detail: "120 runs before and after", link: "#benchmarks" }
    - id: c2
      claim: "Most teams don't benefit from layer caching."
      evidence: { type: opinion, detail: "From 4 codebases; not generalizable." }
  sources:
    - { title: "Docker build cache docs", url: "https://docs.docker.com/build/cache/", relation: background }
  related: []               # slugs of other posts under writing/
  limitations:
    - "Doesn't apply to self-hosted runners with persistent disks."
  next_steps:
    - { action: "Copy the workflow file", link: "ci.yml" }
---
```

Every `agent:` field is optional. Leave out what doesn't apply; the tools return empty lists.

Rules the build enforces (the quarto-webmcp extension fails the render otherwise):

- Each claim has a unique `id`, a `claim` and `evidence.type`.
- `evidence.type` is `measured` (AJ measured it), `experienced` (from AJ's own practice),
  `cited` (from a linked source) or `opinion` (AJ's judgment).
- Each source has a `url`; `relation` is `supports`, `contradicts`, `builds-on` or `background`.

Links can be `#anchor` (a heading in this post), a path relative to the post, or a full URL.
Second-level headings (`##`) get anchors from their text: `## Benchmarks` is `#benchmarks`.

## How it fits together

| Piece | Job |
|---|---|
| `_extensions/alexanderwiebe/webmcp/` | The [quarto-webmcp](https://github.com/alexanderwiebe/quarto-webmcp) extension: validates `agent:`, embeds each page's data, and registers the site and post tools |
| `webmcp:` in `_quarto.yml` | Extension settings: owner, posts folder (`writing`), theme buttons, this site's layout selectors, origin-trial tokens |
| `webmcp-index.ts` (post-render) | Writes `webmcp-index.json`, which `list_posts`, `get_post`, `get_page` and `search_site` read |
| `_includes/site-tools.html` | This site's own tools: `about_aj_wiebe`, `list_projects`, `get_project`, `get_experience`, `list_research` |
| `_filters/writing-post.lua` | Wraps the post in the site chrome (masthead, crumb, title, dek, dates) |
| `writing/_metadata.yml` | Turns off Quarto's title block for `writing/` (the filter draws its own) |
| `writing/index.qmd` + `_post-rows.ejs` | Lists posts automatically, newest first |

Post pages get `get_post_summary`, `check_post_fit`, `get_post_credibility`, `get_post_claims`,
`get_post_context` and `get_post_next_steps` from the extension.

To update the extension:

```bash
quarto add alexanderwiebe/quarto-webmcp
```

Tool to reader question:

| Tool | Questions |
|---|---|
| `get_post_summary` | What is this about? What's the main point? |
| `check_post_fit` | Is this relevant to me? Will it work for my situation? |
| `get_post_credibility` | Who wrote it and why trust them? Is it current? Is it selling something? |
| `get_post_claims` | How do they know? Is the evidence any good? |
| `get_post_context` | How does it fit with what else I know? |
| `get_post_next_steps` | So what? What do I do with this? |

## Checking a post

In the browser console on the post page:

```js
window.siteTools.list().map(t => t.name)
JSON.parse(await window.siteTools.call('get_post_claims', {}))
```
