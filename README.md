# systemsbyaj.com

AJ Wiebe's personal site. Built from a written product spec, in
stages — discovery, information architecture, voice, design,
implementation — each stage documented before the next one started.
See `docs/discovery.md`, `docs/ia.md`, `docs/voice.md`, and
`docs/design.md` for that process.

Static site, built with [Quarto](https://quarto.org). Content lives in
`.qmd` files at the repo root and under `writing/` and `projects/`.
Design tokens and layout are in `styles.css`.

## Local development

This repo's devcontainer has Quarto and a Python/Jupyter environment
pre-installed (the Jupyter toolchain is there for future notebook-based
posts, not required for the current pages).

```bash
quarto preview                  # live preview at localhost
quarto render                   # render the site to _site/
```

## Deployment

`.github/workflows/publish.yml` renders and publishes to the
`gh-pages` branch on every push to `main`. The `CNAME` file points
GitHub Pages at `systemsbyaj.com`.
