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
      vim.g.opencode_opts = {
        events = {
          enabled = true,
        },
      }
      vim.o.autoread = true

      local Server = require("opencode.server")
      local Promise = require("opencode.promise")
      local original_get = Server.get
      Server.get = function()
        return original_get():next(function(server)
          return Promise.new(function(resolve)
            server:get_sessions(function(sessions)
              if sessions and #sessions > 0 then
                server:select_session(sessions[1].id)
              end
              resolve(server)
            end)
          end)
        end)
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "OpencodeEvent:session.idle",
        callback = function()
          vim.notify("OpenCode 回复完毕", vim.log.levels.INFO, { title = "opencode" })
        end,
      })
    end,
  },
}
