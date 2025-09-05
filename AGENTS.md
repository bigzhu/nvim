# Repository Guidelines

This repository contains a Neovim configuration built on LazyVim and lazy.nvim. Use this guide to contribute safely and consistently.

## Project Structure & Module Organization
- `init.lua`: Entry point; loads Lazy and repo config.
- `lua/config/`: Core settings (`options.lua`, `keymaps.lua`, `autocmds.lua`, `lazy.lua`).
- `lua/plugins/`: Plugin specs and overrides (one concern per file; snake_case names).
- `spell/`: Custom spell files.
- `lazy-lock.json` and `lazyvim.json`: Plugin lockfile and LazyVim settings.
- `stylua.toml`: Lua formatting rules.

## Build, Test, and Development Commands
- Run locally: `nvim` (after linking this repo to `~/.config/nvim`).
- Sync/update plugins: `:Lazy sync` (or `nvim --headless '+Lazy! sync' +qa`).
- Health checks: `:checkhealth` to verify tooling and providers.
- Format Lua: `stylua .` (check only: `stylua --check .`).

## Coding Style & Naming Conventions
- Lua with 2 spaces; column width 120 (see `stylua.toml`).
- File names: `lua/plugins/<topic>.lua` and `lua/config/<area>.lua`.
- Keep plugin specs focused; prefer one plugin/group per file with `opts = {}`.
- Keymaps include a clear `desc` and use LazyVim helpers where available.
- Avoid machine‑specific paths in code; prefer env vars or per‑host overrides.

## Testing Guidelines
- Sanity load: `nvim --headless '+qa'` to ensure startup succeeds.
- Plugin state: `nvim --headless '+Lazy! sync' +qa` must complete without errors.
- Manual: open `:messages`, run `:checkhealth`, test keymaps/features you changed.

## Commit & Pull Request Guidelines
- Messages: imperative mood; prefer Conventional Commits when possible
  (e.g., `feat(plugins): add obsidian config`, `fix(keymaps): avoid clash`).
- Include scope keywords like `plugins`, `obsidian`, `keymaps`, `options`.
- PRs: describe motivation and user impact; list changed modules; add screenshots or short clips for UI/UX changes; link related issues.

## Security & Configuration Tips
- Do not commit API keys or secrets. For AI/CLI tools, read keys from env vars.
- If adding workspace‑specific paths (e.g., Obsidian), document them clearly and keep them configurable.

## Agent‑Specific Notes
- AI integrations live in `lua/plugins/claude-code.lua` and `lua/plugins/codex.lua`.
- Keep provider setup minimal in git; prefer runtime selection (`:ClaudeCodeSelectModel`) and environment‑based auth.

