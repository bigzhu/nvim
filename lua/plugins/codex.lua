return {
  {
    "ishiooon/codex.nvim",
    dependencies = { "folke/snacks.nvim" },
    cmd = { "Codex", "CodexOpen", "CodexFocus", "CodexSend", "CodexTreeAdd" },
    opts = {
      status_indicator = {
        enabled = false,
      },
    },
    config = function(_, opts)
      require("codex").setup(opts)
    end,
    keys = {
      { "<leader>ac", "<cmd>Codex<cr>", desc = "Codex: Toggle" },
      { "<leader>ar", "<cmd>CodexOpen resume --last<cr>", desc = "Codex: Resume Last Session" },
      { "<leader>af", "<cmd>CodexFocus<cr>", desc = "Codex: Focus" },
      { "<leader>as", "<cmd>CodexSend<cr>", mode = "v", desc = "Codex: Send Selection" },
    },
  },
}
