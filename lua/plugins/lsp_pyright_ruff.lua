-- Override LSP settings for Pyright and Ruff to align with project config
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        pyright = function(_, opts)
          local util = require("lspconfig.util")
          opts.root_dir = util.root_pattern("pyrightconfig.json", "pyproject.toml", ".git")
          opts.settings = vim.tbl_deep_extend("force", opts.settings or {}, {
            python = {
              analysis = {
                diagnosticMode = "workspace", -- analyze the whole workspace
                typeCheckingMode = "strict",
                useLibraryCodeForTypes = true,
                stubPath = "typings",
                reportMissingTypeStubs = "warning",
                reportMissingImports = "error",
              },
              venvPath = ".",
              venv = ".venv",
            },
          })
          return false -- continue with default lspconfig setup
        end,
        ruff = function(_, opts)
          local util = require("lspconfig.util")
          opts.root_dir = util.root_pattern("pyrightconfig.json", "pyproject.toml", ".git")
          return false
        end,
      },
    },
  },
}

