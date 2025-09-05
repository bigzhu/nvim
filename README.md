# 💤 LazyVim (Repo Setup)

This repo is a Neovim config built on LazyVim and lazy.nvim, tailored with custom plugins and keymaps.

## Getting Started
- Link this repo as your config: `ln -s "$PWD" ~/.config/nvim`.
- Start Neovim: `nvim` (first run installs plugins).
- Sync plugins headlessly: `make sync` or `nvim --headless '+Lazy! sync' +qa`.

## Environment Variables
- `OBSIDIAN_DIR`: path to your Obsidian vault (default `~/Sync/home/cheese`).
- `OBSIDIAN_DEV_DIR`: local development path for `obsidian.nvim` (if present, loads from `dir`).
  Add to your shell rc, e.g. `export OBSIDIAN_DIR="$HOME/Sync/home/cheese"`.

## Dev Workflow
- Format Lua: `make fmt` (or `stylua .`).
- Quick checks: `make check` (format check + headless startup).
- Pre-commit hooks: `pre-commit install` (runs Stylua + headless Neovim check).

## Troubleshooting
- Run `:checkhealth` for missing dependencies (Python/Node providers, formatters).
- If Neovim fails to start, try `nvim -u NONE` to isolate issues.

For contributor guidelines, see `AGENTS.md`.
