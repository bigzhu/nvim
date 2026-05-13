return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCLI",
      "CodeCompanionCmd",
    },
    keys = {
      { "<leader>CC", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion: 操作菜单", mode = { "n", "v" } },
      { "<leader>Cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion: 切换聊天" },
      { "<leader>Ca", "<cmd>CodeCompanionChat Add<cr>", desc = "CodeCompanion: 添加选区", mode = "v" },
      { "<leader>Ci", "<cmd>CodeCompanion<cr>", desc = "CodeCompanion: 内联协助", mode = { "n", "v" } },
      { "<leader>Cl", "<cmd>CodeCompanionCLI<cr>", desc = "CodeCompanion: Codex CLI" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        acp = {
          codex = function()
            return require("codecompanion.adapters").extend("codex", {
              defaults = {
                auth_method = "chatgpt",
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = "codex",
        },
        cli = {
          agent = "codex",
          agents = {
            codex = {
              cmd = "codex",
              args = {},
              description = "Codex CLI",
              provider = "terminal",
            },
          },
        },
      },
      display = {
        action_palette = {
          provider = "snacks",
        },
      },
    },
  },
}
