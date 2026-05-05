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

      -- <leader>ap = prompt: 根据选中内容或光标位置发起预设提问
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

      -- <leader>aa = add: 将选中内容或当前行追加到 opencode 上下文
      vim.keymap.set({ "n", "x" }, "<leader>aa", function()
        return require("opencode").operator("@this ")
      end, { desc = "Opencode: 追加选区", expr = true })
      vim.keymap.set("n", "<leader>aal", function()
        return require("opencode").operator("@this ") .. "_"
      end, { desc = "Opencode: 追加当前行", expr = true })

      -- <leader>ac = command: 会话和代理管理
      vim.keymap.set({ "n", "x" }, "<leader>acl", function()
        require("opencode").command("session.list")
      end, { desc = "Opencode: 列出会话" })
      vim.keymap.set({ "n", "x" }, "<leader>acn", function()
        require("opencode").command("session.new")
      end, { desc = "Opencode: 新会话" })
      vim.keymap.set({ "n", "x" }, "<leader>acs", function()
        require("opencode").command("session.select")
      end, { desc = "Opencode: 选择会话" })
      vim.keymap.set({ "n", "x" }, "<leader>ach", function()
        require("opencode").command("session.share")
      end, { desc = "Opencode: 分享会话" })
      vim.keymap.set({ "n", "x" }, "<leader>aci", function()
        require("opencode").command("session.interrupt")
      end, { desc = "Opencode: 中断会话" })
      vim.keymap.set({ "n", "x" }, "<leader>acc", function()
        require("opencode").command("session.compact")
      end, { desc = "Opencode: 压缩会话" })
      vim.keymap.set({ "n", "x" }, "<leader>acu", function()
        require("opencode").command("session.undo")
      end, { desc = "Opencode: 撤销" })
      vim.keymap.set({ "n", "x" }, "<leader>acr", function()
        require("opencode").command("session.redo")
      end, { desc = "Opencode: 重做" })
      vim.keymap.set({ "n", "x" }, "<leader>aca", function()
        require("opencode").command("agent.cycle")
      end, { desc = "Opencode: 切换代理" })

      -- <leader>az = scroll: 翻页定位
      vim.keymap.set({ "n", "t" }, "<leader>azu", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "Opencode: 上半翻" })
      vim.keymap.set({ "n", "t" }, "<leader>azd", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "Opencode: 下半翻" })
      vim.keymap.set({ "n", "t" }, "<leader>azp", function()
        require("opencode").command("session.page.up")
      end, { desc = "Opencode: 上一整页" })
      vim.keymap.set({ "n", "t" }, "<leader>azn", function()
        require("opencode").command("session.page.down")
      end, { desc = "Opencode: 下一整页" })
      vim.keymap.set({ "n", "x" }, "<leader>azf", function()
        require("opencode").command("session.first")
      end, { desc = "Opencode: 跳转首消息" })
      vim.keymap.set({ "n", "x" }, "<leader>azl", function()
        require("opencode").command("session.last")
      end, { desc = "Opencode: 跳转末消息" })

      -- <leader>ai = input: TUI 操作
      vim.keymap.set({ "n", "i", "t" }, "<leader>ais", function()
        require("opencode").command("prompt.submit")
      end, { desc = "Opencode: 提交输入" })
      vim.keymap.set({ "n", "i", "t" }, "<leader>aic", function()
        require("opencode").command("prompt.clear")
      end, { desc = "Opencode: 清除输入" })

      -- <leader>au = ui: 操作界面
      vim.keymap.set({ "n", "x" }, "<leader>au", function()
        require("opencode").select()
      end, { desc = "Opencode: 操作菜单" })
      vim.keymap.set({ "n", "t" }, "<leader>aut", function()
        require("opencode").toggle()
      end, { desc = "Opencode: 切换窗口" })

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
