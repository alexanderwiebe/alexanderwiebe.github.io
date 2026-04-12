setup:
	pip install '.[dev]' && pre-commit install

init:
	python scripts/init_template.py
