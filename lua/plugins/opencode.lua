return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    dependencies = {
      {
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {},
          picker = {
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    keys = {
      { "<leader>aa", function() require("opencode").ask("@this: ", { submit = true }) end, desc = "Opencode: Ask", mode = { "n", "x" } },
      { "<leader>as", function() require("opencode").select() end, desc = "Opencode: Select Action", mode = { "n", "x" } },
      { "<leader>at", function() require("opencode").toggle() end, desc = "Opencode: Toggle", mode = { "n", "t" } },
      { "go", function() return require("opencode").operator("@this ") end, desc = "Opencode: Add Range", mode = { "n", "x" }, expr = true },
      { "goo", function() return require("opencode").operator("@this ") .. "_" end, desc = "Opencode: Add Line", expr = true },
    },
    config = function()
      vim.g.opencode_opts = {}
      vim.o.autoread = true
    end,
  },
}
