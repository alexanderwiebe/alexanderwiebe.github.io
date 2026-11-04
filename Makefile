setup: extensions
	pip install '.[dev]' && pre-commit install

# Quarto extensions from quarto-extensions.txt (not committed; see .gitignore)
extensions:
	scripts/install-quarto-extensions.sh

.PHONY: setup extensions init

init:
	python scripts/init_template.py
