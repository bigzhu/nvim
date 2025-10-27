return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.markdown = { "prettierd", "prettier", "mdformat" }

      local old = opts.format_on_save
      opts.format_on_save = function(bufnr)
        if vim.bo[bufnr].filetype == "markdown" then
          return { lsp_fallback = true, timeout_ms = 2000 }
        end
        if type(old) == "function" then
          return old(bufnr)
        end
        return old
      end
    end,
  },
}
