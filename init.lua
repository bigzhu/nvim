require("config.options")
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Optional: load machine-specific overrides if present (ignored by git)
pcall(require, "config.local")
