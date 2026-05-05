return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.explorer = opts.explorer or {}
    end,
  },
  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    init = function()
      local group = vim.api.nvim_create_augroup("snacks_explorer_refresh", { clear = true })

      local function refresh_explorer()
        local ok, picker_mod = pcall(require, "snacks.picker")
        if not ok then
          return
        end
        local pickers = picker_mod.get({ source = "explorer", tab = false })
        local actions_ok, actions_mod = pcall(require, "snacks.explorer.actions")
        if not actions_ok then
          return
        end
        local update = actions_mod.actions and actions_mod.actions.explorer_update
        if not update then
          return
        end
        for _, picker in ipairs(pickers) do
          if picker and not picker.closed then
            update(picker)
          end
        end
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "DiagnosticChanged" }, {
        group = group,
        desc = "Refresh snacks explorer state",
        callback = refresh_explorer,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimFormatting",
        group = group,
        desc = "Refresh snacks explorer after formatting",
        callback = refresh_explorer,
      })
    end,
  },
}
