# Outstanding tasks

Internal tracking doc, not linked from the public site. Everything
still open after the Stage 1–6 build, for AJ to review and check off.

## Content, deferred on purpose

- [ ] **Writing stays empty** until there's a real first post. No RSS
  feed wiring until then either — building the feed machinery for zero
  posts would just be complexity with nothing to serve.
- [ ] **"This Site" project page's "What I learned"** is intentionally
  left blank (`projects/this-site.qmd`) — write it once the build has
  enough history to reflect on honestly.
- [ ] **LinkedIn About/headline blurb and any posts/articles** — optional
  seed material for About or the first Writing entries, if any exist.
  Not required for anything currently live.

## Domain / hosting

- [ ] **Point `systemsbyaj.com` at the site.** Full instructions in
  `docs/cloudflare-domain-setup.md` — two paths (simple redirect vs.
  genuinely-independent dual hosting via Cloudflare Pages), pick one.
  Nothing here is done yet: no DNS records exist for the domain.

## Possible future Projects entries (not added without your say-so)

Found while re-checking "private" repos that turned out to be public
— see `docs/discovery.md`'s "Previously unverified repos" section for
the full detail on each:

- [ ] `homelab-todo-bot` — a real AI-agent project (Telegram bot,
  Claude CLI plan/revise/execute with human approval gates). Fits the
  "AI agents" theme as well as AI Briefing does.
- [ ] `svg-node-editor` (actually "AI Document") — an AI-powered
  document editor, Angular + NestJS + Bun workspaces. Thematically
  close to aj-starter-gold, more fully realized.
- [ ] `docker`'s infra (feeds the `ai-briefing` pipeline and possibly
  the Research Knowledge Graph via `zotero-ingest`) could get a
  one-line mention inside the AI Briefing project page rather than its
  own entry, if you want that connection visible.

## Repo cleanup (low priority)

- [ ] The old `base-notebook` template scaffold is still in the repo:
  `notebooks/` (generic template notebooks, not site content),
  `jupyter/`, `scripts/init_template.py`, `pyproject.toml`'s packaging
  metadata, `base_notebook.egg-info/`, `build/`. None of it is used by
  the site (both are explicitly excluded from the Quarto render).
  Deleting it is straightforward whenever — just note that
  `.github/workflows/ci.yml` currently lints `notebooks/` with `nbqa`
  and would need updating if that directory goes away.
- [ ] No favicon set for the real site yet (only the Stage 4 design
  mockup artifact had one — that doesn't carry over to the actual
  Quarto build).

## Verify after first real deploy

- [ ] Confirm the pushed build actually renders correctly on GitHub
  Pages once DNS/domain work (above) is done — this was only checked
  with a local `quarto render`, not the live deploy.
