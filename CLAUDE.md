# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a LazyVim-based Neovim configuration with custom plugins and settings. The configuration is structured around the LazyVim framework with personal customizations and integrations for Obsidian note-taking and code execution.

## Architecture

### Core Structure
- `init.lua` - Entry point that bootstraps lazy.nvim and loads the configuration
- `lua/config/` - Core configuration files (options, keymaps, autocmds, lazy setup)
- `lua/plugins/` - Plugin specifications and configurations
- `lazyvim.json` - LazyVim extras and version tracking
- `lazy-lock.json` - Plugin version lockfile

### Plugin Management
The configuration uses lazy.nvim for plugin management with LazyVim as the base distribution. Plugins are loaded from:
- LazyVim core plugins
- LazyVim extras (defined in `lazyvim.json`)
- Custom plugins in `lua/plugins/`

### Key Integrations
- **Obsidian.nvim**: Custom local version for note-taking integration with ~/Sync/home/cheese workspace
- **Code Runner**: Configured for Go, Dart/Flutter, Python (with Poetry), and Markdown execution
- **Claude Code**: Integration plugin for Claude Code functionality

## Development Commands

### Code Formatting
```bash
# Format Lua code with StyLua (configured in stylua.toml)
stylua lua/
```

### Plugin Management
```bash
# Update plugins
nvim -c "Lazy update" -c "qa"

# Sync plugins (install missing, remove unused)
nvim -c "Lazy sync" -c "qa"

# Check plugin status
nvim -c "Lazy" -c "qa"
```

### Testing Configuration
```bash
# Start Neovim with minimal config for testing
nvim --cmd "set rtp+=." --cmd "runtime plugin/plenary.vim" -c "PlenaryBustedDirectory lua/tests/ {minimal_init = 'lua/minimal_init.lua'}"
```

## Configuration Details

### Custom Options (lua/config/options.lua)
- Disabled spell checking (`spelllang = {}`)
- Disabled relative line numbers (`relativenumber = false`)

### Custom Keymaps (lua/config/keymaps.lua)
**Obsidian Integration:**
- `<C-f>` - Quick switch between notes
- `<C-j>` - Search note content
- `<C-g>` - Create daily note
- `<C-n>` - Create new note
- `<C-t>` - Insert template
- `<CR>` (visual mode) - Create link from selection

**Code Execution:**
- `<leader>r` - Run current code file

### Plugin Configurations

**Obsidian.nvim** (`lua/plugins/obsidian.lua`):
- Uses local development version from `~/Sync/Projects/obsidian.nvim`
- Workspace: `~/Sync/home/cheese`
- Custom note ID function using title as filename
- Custom URL and image opening functions

**Code Runner** (`lua/plugins/code_runner.lua`):
- Go: `go test $dir`
- Dart: `flutter test`
- Python: `poetry run python`
- Markdown: Opens in Obsidian

**Formatting** (`stylua.toml`):
- 2-space indentation
- 120 character column width

## File Patterns

### Plugin Files
All plugin configurations in `lua/plugins/` should return a table with plugin specifications following lazy.nvim format:
```lua
return {
  "plugin/name",
  dependencies = { "dep1", "dep2" },
  config = function()
    -- plugin setup
  end,
}
```

### Adding New Plugins
1. Create new file in `lua/plugins/`
2. Follow existing plugin configuration patterns
3. Use lazy loading when appropriate
4. Document any custom keymaps or configurations