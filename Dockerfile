FROM mcr.microsoft.com/devcontainers/python:3.13

# System dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Install Quarto CLI
RUN ARCH=$(dpkg --print-architecture) \
    && curl -LO "https://quarto.org/download/latest/quarto-linux-${ARCH}.deb" \
    && dpkg -i "quarto-linux-${ARCH}.deb" \
    && rm "quarto-linux-${ARCH}.deb"

# Set up workspace
WORKDIR /workspace

# Copy source code in early
COPY . .

# Upgrade pip and install Python packages as root
RUN pip install --upgrade pip \
    && pip install ".[dev]" \
    && mkdir -p /usr/local/share/jupyter/lab/settings \
    && cp jupyter/overrides.json /usr/local/share/jupyter/lab/settings/overrides.json

USER vscode

# Ensure ~/.local/bin is in PATH for the vscode user
RUN echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc
