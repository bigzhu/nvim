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
    config = function()
      vim.o.autoread = true

      vim.g.opencode_opts = {
        lsp = { enabled = true },
      }

      -- 对当前选中内容或光标位置发起提问
      vim.keymap.set({ "n", "x" }, "<leader>aa", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Opencode: Ask" })

      -- 打开操作菜单（内置 prompt / 命令 / server 控制）
      vim.keymap.set({ "n", "x" }, "<leader>as", function()
        require("opencode").select()
      end, { desc = "Opencode: Select Action" })

      -- 显示/隐藏 opencode 终端窗口
      vim.keymap.set({ "n", "t" }, "<leader>at", function()
        require("opencode").toggle()
      end, { desc = "Opencode: Toggle" })

      -- 将选中区域或当前行作为上下文追加到 opencode
      vim.keymap.set({ "n", "x" }, "go", function()
        return require("opencode").operator("@this ")
      end, { desc = "Opencode: Add Range", expr = true })

      -- 将当前行作为上下文追加（不带末尾空格，立即发送）
      vim.keymap.set("n", "goo", function()
        return require("opencode").operator("@this ") .. "_"
      end, { desc = "Opencode: Add Line", expr = true })

      -- 在 opencode 终端中向上翻半页
      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "Opencode: Scroll up" })

      -- 在 opencode 终端中向下翻半页
      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "Opencode: Scroll down" })

      vim.api.nvim_create_autocmd("User", {
        pattern = "OpencodeEvent:session.idle",
        callback = function()
          vim.notify("OpenCode 回复完毕", vim.log.levels.INFO, { title = "opencode" })
          if vim.fn.has("mac") == 1 then
            vim.fn.jobstart({ "afplay", "/System/Library/Sounds/Hero.aiff" })
          end
        end,
      })
    end,
  },
}
