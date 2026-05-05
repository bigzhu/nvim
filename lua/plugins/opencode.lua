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
        prompts = {
          ask = { prompt = "@this: ", submit = true },
          diagnostics = { prompt = "解释 @diagnostics", submit = true },
          diff = { prompt = "审查以下 git 差异的正确性和可读性：@diff", submit = true },
          document = { prompt = "为 @this 添加注释文档", submit = true },
          explain = { prompt = "解释 @this 及其上下文", submit = true },
          fix = { prompt = "修复 @diagnostics", submit = true },
          implement = { prompt = "实现 @this", submit = true },
          optimize = { prompt = "优化 @this 的性能和可读性", submit = true },
          review = { prompt = "审查 @this 的正确性和可读性", submit = true },
          test = { prompt = "为 @this 添加测试", submit = true },
        },
      }

      local prompt_keys = {
        ask = { key = "a", desc = "Opencode: 提问" },
        diagnostics = { key = "dia", desc = "Opencode: 诊断解释" },
        diff = { key = "dif", desc = "Opencode: 差异审查" },
        document = { key = "do", desc = "Opencode: 添加注释" },
        explain = { key = "e", desc = "Opencode: 代码解释" },
        fix = { key = "f", desc = "Opencode: 修复诊断" },
        implement = { key = "i", desc = "Opencode: 实现代码" },
        optimize = { key = "o", desc = "Opencode: 性能优化" },
        review = { key = "r", desc = "Opencode: 审查代码" },
        test = { key = "t", desc = "Opencode: 添加测试" },
      }
      for name, mapping in pairs(prompt_keys) do
        local p = vim.g.opencode_opts.prompts[name]
        if p then
          vim.keymap.set({ "n", "x" }, "<leader>ap" .. mapping.key, function()
            require("opencode").ask(p.prompt, { submit = p.submit })
          end, { desc = mapping.desc })
        end
      end

      -- 打开操作菜单（内置 prompt / 命令 / server 控制）
      vim.keymap.set({ "n", "x" }, "<leader>as", function()
        require("opencode").select()
      end, { desc = "Opencode: 操作菜单" })

      -- 显示/隐藏 opencode 终端窗口
      vim.keymap.set({ "n", "t" }, "<leader>at", function()
        require("opencode").toggle()
      end, { desc = "Opencode: 切换窗口" })

      -- 将选中区域或当前行作为上下文追加到 opencode
      vim.keymap.set({ "n", "x" }, "<leader>aa", function()
        return require("opencode").operator("@this ")
      end, { desc = "Opencode: 追加选区", expr = true })

      -- 将当前行作为上下文追加（不带末尾空格，立即发送）
      vim.keymap.set("n", "<leader>aal", function()
        return require("opencode").operator("@this ") .. "_"
      end, { desc = "Opencode: 追加当前行", expr = true })

      -- 在 opencode 终端中向上翻半页
      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "Opencode: 上半翻" })

      -- 在 opencode 终端中向下翻半页
      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "Opencode: 下半翻" })

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
