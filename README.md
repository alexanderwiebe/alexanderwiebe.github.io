# Template for jupyter notebooks

VS Code DevContainers for working with jupyter notebooks

## 🚀 Features
- Local or GitHub Codespaces support
- VS Code + Copilot Chat integration

## 🛠️ Getting Started

1. Open this folder in **VS Code**
2. If prompted, reopen in container
3. Run `jupyter lab` inside the terminal
4. Explore `notebooks/`

## 📄 Quarto

[Quarto](https://quarto.org) is pre-installed in the dev container and renders notebooks to HTML, PDF, and more.

**VS Code tasks** (via `Tasks: Run Task`):

| Task | Description |
|------|-------------|
| Quarto Preview | Live preview at `localhost:4848` |
| Quarto Render | Render all notebooks to `_site/` |
| Quarto Render Active File | Render only the open file |
| Quarto Publish | Publish to Quarto Pub / GitHub Pages |

**CLI equivalents:**

```bash
quarto preview                  # live preview
quarto render                   # render all to _site/
quarto render notebooks/01_init_notebook.ipynb
quarto publish quarto-pub       # publish to quartopub.com
```

Project output settings are in `_quarto.yml`.

## 🔑 API Keys

Set your OpenAI key (if using) as an environment variable:

```bash
export OPENAI_API_KEY="your-key"
