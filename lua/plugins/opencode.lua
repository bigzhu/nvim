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
          commit = { prompt = "git commit，用中文写提交信息", submit = true },
        },
      }

      -- <leader>ap = prompt: 根据选中内容或光标位置发起预设提问
      local prompt_keys = {
        ask = { key = "a", desc = "Ask: 提问" },
        diagnostics = { key = "dia", desc = "Diagnostics: 诊断解释", direct = true },
        diff = { key = "dif", desc = "Diff: 差异审查", direct = true },
        document = { key = "do", desc = "Document: 添加注释", direct = true },
        explain = { key = "e", desc = "Explain: 代码解释", direct = true },
        fix = { key = "f", desc = "Fix: 修复诊断", direct = true },
        implement = { key = "i", desc = "Implement: 实现代码", direct = true },
        optimize = { key = "o", desc = "Optimize: 性能优化", direct = true },
        review = { key = "r", desc = "Review: 审查代码", direct = true },
        test = { key = "t", desc = "Test: 添加测试", direct = true },
        commit = { key = "c", desc = "Commit: git 提交", direct = true },
      }
      for name, mapping in pairs(prompt_keys) do
        local p = vim.g.opencode_opts.prompts[name]
        if p then
          vim.keymap.set({ "n", "x" }, "<leader>ap" .. mapping.key, function()
            if mapping.direct then
              require("opencode").prompt(p.prompt)
            else
              require("opencode").ask(p.prompt, { submit = p.submit })
            end
          end, { desc = mapping.desc })
        end
      end

      -- <leader>aa = add: 将选中内容或当前行追加到 opencode 上下文
      vim.keymap.set({ "n", "x" }, "<leader>aa", function()
        return require("opencode").operator("@this ")
      end, { desc = "Add: 追加选区", expr = true })
      vim.keymap.set("n", "<leader>aal", function()
        return require("opencode").operator("@this ") .. "_"
      end, { desc = "Add Line: 追加当前行", expr = true })

      -- <leader>ac = command: 会话和代理管理
      vim.keymap.set({ "n", "x" }, "<leader>acl", function()
        require("opencode").command("session.list")
      end, { desc = "List: 列出会话" })
      vim.keymap.set({ "n", "x" }, "<leader>acn", function()
        require("opencode").command("session.new")
      end, { desc = "New: 新会话" })
      vim.keymap.set({ "n", "x" }, "<leader>acs", function()
        require("opencode").command("session.select")
      end, { desc = "Select: 选择会话" })
      vim.keymap.set({ "n", "x" }, "<leader>ach", function()
        require("opencode").command("session.share")
      end, { desc = "Share: 分享会话" })
      vim.keymap.set({ "n", "x" }, "<leader>aci", function()
        require("opencode").command("session.interrupt")
      end, { desc = "Interrupt: 中断会话" })
      vim.keymap.set({ "n", "x" }, "<leader>acc", function()
        require("opencode").command("session.compact")
      end, { desc = "Compact: 压缩会话" })
      vim.keymap.set({ "n", "x" }, "<leader>acu", function()
        require("opencode").command("session.undo")
      end, { desc = "Undo: 撤销" })
      vim.keymap.set({ "n", "x" }, "<leader>acr", function()
        require("opencode").command("session.redo")
      end, { desc = "Redo: 重做" })
      vim.keymap.set({ "n", "x" }, "<leader>aca", function()
        require("opencode").command("agent.cycle")
      end, { desc = "Agent: 切换代理" })

      -- <leader>az = scroll: 翻页定位
      vim.keymap.set({ "n", "t" }, "<leader>azu", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "Up: 上半翻" })
      vim.keymap.set({ "n", "t" }, "<leader>azd", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "Down: 下半翻" })
      vim.keymap.set({ "n", "t" }, "<leader>azp", function()
        require("opencode").command("session.page.up")
      end, { desc = "Page Up: 上一整页" })
      vim.keymap.set({ "n", "t" }, "<leader>azn", function()
        require("opencode").command("session.page.down")
      end, { desc = "Page Down: 下一整页" })
      vim.keymap.set({ "n", "x" }, "<leader>azf", function()
        require("opencode").command("session.first")
      end, { desc = "First: 首消息" })
      vim.keymap.set({ "n", "x" }, "<leader>azl", function()
        require("opencode").command("session.last")
      end, { desc = "Last: 末消息" })

      -- <leader>ai = input: TUI 操作
      vim.keymap.set({ "n", "i", "t" }, "<leader>ais", function()
        require("opencode").command("prompt.submit")
      end, { desc = "Submit: 提交输入" })
      vim.keymap.set({ "n", "i", "t" }, "<leader>aic", function()
        require("opencode").command("prompt.clear")
      end, { desc = "Clear: 清除输入" })

      -- <leader>au = ui: 操作界面
      vim.keymap.set({ "n", "x" }, "<leader>au", function()
        require("opencode").select()
      end, { desc = "UI Menu: 操作菜单" })
      vim.keymap.set({ "n", "t" }, "<leader>aut", function()
        require("opencode").toggle()
      end, { desc = "Toggle: 切换窗口" })

      -- session.idle 事件: opencode 回复完毕后发送通知并播放提示音
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
