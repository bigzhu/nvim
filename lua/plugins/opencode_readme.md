# opencode.nvim

<https://github.com/user-attachments/assets/077daa78-d401-4b8b-98d1-9ba9f94c2330>

## ✨ 功能特性

- 连接_任意_ `opencode` 实例，或提供内置实例
- 共享编辑器上下文（缓冲区、选区、诊断信息等）
- 输入提示词时支持补全、高亮和普通模式
- 从提示词库中选择提示词，也可自定义
- 执行命令
- 监听并响应事件
- 查看、接受/拒绝、重新加载编辑
- 通过进程内 LSP 与 `opencode` 交互
- _Vim 风格_ — 支持范围和点重复（dot-repeat）
- 简洁合理的默认配置，快速上手

## 📦 安装配置

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "nickjvandyke/opencode.nvim",
  version = "*", -- 最新稳定版
  dependencies = {
    {
      -- 推荐集成 `snacks.nvim`，但非必须
      ---@module "snacks" <- 加载 `snacks.nvim` 类型，用于配置智能提示
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {}, -- 增强 `ask()`
        picker = { -- 增强 `select()`
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
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
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- 在此添加你的配置；可将光标置于类型或字段上查看详细说明
    }

    vim.o.autoread = true -- `opts.events.reload` 所需

    -- 推荐/示例键映射
    vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "提问 opencode…" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "执行 opencode 操作…" })
    vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "切换 opencode" })

    vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "添加范围到 opencode", expr = true })
    vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "添加行到 opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "opencode 向上滚动" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode 向下滚动" })

    -- 如果你使用了上面的 <C-a> 和 <C-x> 键映射，可能需要以下映射 — 否则可考虑使用 <leader>o…（并从 toggle 映射中移除终端模式）
    vim.keymap.set("n", "+", "<C-a>", { desc = "递增光标下数字", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "递减光标下数字", noremap = true })
  end,
}
```

### [nixvim](https://github.com/nix-community/nixvim)

```nix
programs.nixvim = {
  extraPlugins = [
    pkgs.vimPlugins.opencode-nvim
  ];
};
```

> [!TIP]
> 安装完成后请运行 `:checkhealth opencode`。

## ⚙️ 配置

`opencode.nvim` 提供了丰富且可靠的默认体验 — 所有可用选项及其默认值详见[此处](./lua/opencode/config.lua)。

### 上下文

`opencode.nvim` 会将提示词中的占位符替换为对应的上下文：

| 占位符        | 上下文                                                   |
| ------------- | -------------------------------------------------------- |
| `@this`       | 操作符范围或可视选区（若有），否则为光标位置             |
| `@buffer`     | 当前缓冲区                                               |
| `@buffers`    | 所有已打开的缓冲区                                       |
| `@visible`    | 可见文本                                                 |
| `@diagnostics`| 当前缓冲区的诊断信息                                     |
| `@quickfix`   | Quickfix 列表                                            |
| `@diff`       | Git 差异                                                 |
| `@marks`      | 全局标记                                                 |
| `@grapple`    | [grapple.nvim](https://github.com/cbochs/grapple.nvim) 标签 |

> [!TIP]
> `opencode` 从磁盘读取引用的文件 — 请先保存你的修改！

### 提示词

选择提示词来审查、解释和改进你的代码：

| 名称          | 提示词                                                             |
| ------------- | ------------------------------------------------------------------ |
| `diagnostics` | 解释 `@diagnostics`                                                |
| `diff`         | 审查以下 git 差异的正确性和可读性：`@diff`                         |
| `document`    | 为 `@this` 添加注释文档                                             |
| `explain`     | 解释 `@this` 及其上下文                                             |
| `fix`         | 修复 `@diagnostics`                                                 |
| `implement`   | 实现 `@this`                                                        |
| `optimize`    | 优化 `@this` 的性能和可读性                                         |
| `review`      | 审查 `@this` 的正确性和可读性                                       |
| `test`        | 为 `@this` 添加测试                                                 |

### 服务器

你可以手动以任意方式运行 `opencode`，`opencode.nvim` 会自动发现它！

> [!IMPORTANT]
> 你_必须_使用 `--port` 参数运行 `opencode` 以暴露其服务器。

如果 `opencode.nvim` 找不到已有的 `opencode` 实例，它会使用配置的服务器为你启动一个，默认为内嵌终端。

#### 键映射

`opencode.nvim` 在内嵌终端中设置了以下普通模式键映射，提供类似 Neovim 的消息导航：

| 键映射   | 命令                     | 说明             |
| -------- | ------------------------ | ---------------- |
| `<C-u>`  | `session.half.page.up`   | 向上滚动半页     |
| `<C-d>`  | `session.half.page.down` | 向下滚动半页     |
| `gg`     | `session.first`          | 跳转到第一条消息  |
| `G`      | `session.last`           | 跳转到最后一条消息 |
| `<Esc>`  | `session.interrupt`      | 中断             |

#### 自定义

以下示例使用 [`snacks.terminal`](https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md) 替代默认终端：

```lua
local opencode_cmd = 'opencode --port'
---@type snacks.terminal.Opts
local snacks_terminal_opts = {
  win = {
    position = 'right',
    enter = false,
    on_win = function(win)
      -- 为任意终端设置键映射和清理逻辑
      require('opencode.terminal').setup(win.win)
    end,
  },
}
---@type opencode.Opts
vim.g.opencode_opts = {
  server = {
    start = function()
      require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts)
    end,
    stop = function()
      require('snacks.terminal').get(opencode_cmd, snacks_terminal_opts):close()
    end,
    toggle = function()
      require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
    end,
  },
}
```

## 🔑 用户自定义键映射

当前配置中为 opencode.nvim 设置了以下快捷键：

| 快捷键 | 模式 | 功能 |
|---|---|---|
| `<C-a>` | n, x | 提问 opencode（自动提交 `@this:` 前缀） |
| `<C-x>` | n, x | 执行 opencode 操作（select 菜单，含切换模型等选项） |
| `<C-.>` | n, t | 切换 opencode 终端窗口 |
| `go` | n, x | 添加选中范围到 opencode |
| `goo` | n | 添加当前行到 opencode |
| `<S-C-u>` | n | opencode 向上滚动半页 |
| `<S-C-d>` | n | opencode 向下滚动半页 |
| `<a-a>` | n, i | 在 snacks picker 输入框中发送到 opencode |
| `+` | n | 恢复 `<C-a>` 的递增功能（因 `<C-a>` 被 opencode 占用） |
| `-` | n | 恢复 `<C-x>` 的递减功能（因 `<C-x>` 被 opencode 占用） |

> 模型切换：按 `<C-x>` 打开 select 菜单，选择模型切换项；或使用命令 `agent.cycle`。

## 🚀 使用方法

### 提问 — `require("opencode").ask()`

向 `opencode` 输入提示词。

- 按 `<Up>` 浏览最近提问。
- 支持上下文和 `opencode` 子代理的高亮与补全。
  - 按 `<Tab>` 触发内置补全。
- 提示词末尾加空格将追加内容而非提交。
- 使用 `snacks.input` 时，通过进程内 LSP 提供补全。

### 选择 — `require("opencode").select()`

选择 `opencode.nvim` 的所有功能。

- 提示词
- 命令
- 服务器控制

使用 `snacks.picker` 时支持高亮和预览。

### 提示 — `require("opencode").prompt()`

向 `opencode` 发送提示。

- 自动注入配置的上下文。
- `opencode` 会解析对文件或子代理的引用。

### 操作符 — `require("opencode").operator()`

将 `prompt` 封装为操作符，支持范围和点重复（dot-repeat）。

### 命令 — `require("opencode").command()`

向 `opencode` 发送命令：

| 命令                     | 说明                                       |
| ------------------------ | ------------------------------------------ |
| `session.list`           | 列出会话                                   |
| `session.new`            | 启动新会话                                 |
| `session.select`         | 选择会话                                   |
| `session.share`          | 分享当前会话                               |
| `session.interrupt`      | 中断当前会话                               |
| `session.compact`        | 压缩当前会话（减少上下文大小）             |
| `session.page.up`        | 消息向上滚动一页                           |
| `session.page.down`      | 消息向下滚动一页                           |
| `session.half.page.up`   | 消息向上滚动半页                           |
| `session.half.page.down` | 消息向下滚动半页                           |
| `session.first`          | 跳转到会话的第一条消息                      |
| `session.last`           | 跳转到会话的最后一条消息                    |
| `session.undo`           | 撤销当前会话的最后一次操作                  |
| `session.redo`           | 重做当前会话中最后撤销的操作                |
| `prompt.submit`          | 提交 TUI 输入                              |
| `prompt.clear`           | 清除 TUI 输入                              |
| `agent.cycle`            | 切换选中的代理                             |

### LSP

> [!WARNING]
> 此功能为实验性！可通过 `vim.g.opencode_opts.lsp.enabled = true` 启用。

`opencode.nvim` 提供进程内 LSP，让你通过熟悉的 LSP 功能与 `opencode` 交互！

| LSP 功能  | `opencode.nvim` 处理方式                                       |
| --------- | --------------------------------------------------------------- |
| 悬停      | 向 `opencode` 请求光标下符号的简要说明                          |
| 代码操作  | 向 `opencode` 请求解释或修复光标下的诊断信息                   |

## 👀 事件

`opencode.nvim` 将 `opencode` 的服务器推送事件（SSE）转发为 `OpencodeEvent` 自动命令：

```lua
-- 处理 `opencode` 事件
vim.api.nvim_create_autocmd("User", {
  pattern = "OpencodeEvent:*", -- 可选：过滤事件类型
  callback = function(args)
    ---@type opencode.server.Event
    local event = args.data.event
    ---@type number
    local port = args.data.port

    -- 查看可用的事件类型及其属性
    vim.notify(vim.inspect(event))
    -- 执行有用的操作
    if event.type == "session.idle" then
      vim.notify("`opencode` 已完成响应")
    end
  end,
})
```

### 编辑

当 `opencode` 编辑文件时，`opencode.nvim` 会自动重新加载对应的缓冲区。

### 权限

当 `opencode` 请求权限时，`opencode.nvim` 会等待空闲后询问你是否批准或拒绝。

#### 编辑

对于编辑请求，`opencode.nvim` 会在新标签页中打开目标文件，并使用 Neovim 的 `:diffpatch` 并排显示提议的修改。可通过 `:h 'diffopt'` 自定义。

| 键映射    | 功能                                                                   |
| -------- | ---------------------------------------------------------------------- |
| `da`     | 接受整个编辑请求                                                       |
| `dr`     | 拒绝整个编辑请求                                                       |
| `]c/[c`  | 下一个/上一个修改                                                      |
| `dp`     | 仅接受光标下差异块（hunk）的本地修改，并拒绝该编辑请求                  |
| `do`     | 仅拒绝光标下差异块（hunk）的本地修改，并拒绝该编辑请求                  |
| `q`      | 关闭差异视图                                                           |

### 状态栏

```lua
require("lualine").setup({
  sections = {
    lualine_z = {
      {
        require("opencode").statusline,
      },
    }
  }
})
```

## 🙏 致谢

- 灵感来源于 [nvim-aider](https://github.com/GeorgesAlkhouri/nvim-aider)、[neopencode.nvim](https://github.com/loukotal/neopencode.nvim) 和 [sidekick.nvim](https://github.com/folke/sidekick.nvim)。
- 使用 `opencode` 的 TUI 以保持简洁 — 如需 Neovim 前端，请参见 [sudo-tee/opencode.nvim](https://github.com/sudo-tee/opencode.nvim)。
- [mcp-neovim-server](https://github.com/bigcodegen/mcp-neovim-server) 可能更适合你，但它缺乏自定义能力，且工具调用速度较慢且不够可靠。