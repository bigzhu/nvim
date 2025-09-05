SHELL := /bin/sh

.PHONY: sync fmt check

# Sync/update plugins headlessly
sync:
	nvim --headless '+Lazy! sync' +qa

# Format Lua files using Stylua
fmt:
	stylua .

# Check formatting and basic headless startup
check:
	stylua --check .
	nvim --headless '+qa'

