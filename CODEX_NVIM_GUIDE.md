# codex.nvim 使用指南

这份文档说明本仓库中 `codex.nvim` 的使用方式、常见工作流和一些实用技巧。

## 当前配置

插件配置文件位于 `lua/plugins/codex.lua`：

```lua
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
```

这里使用 `<leader>a` 作为 AI 相关功能前缀，避免和 LazyVim 或其他插件的默认 `<leader>c` 命令冲突。`config` 中显式调用 `require("codex").setup(opts)`，用于注册 `:Codex`、`:CodexOpen`、`:CodexFocus` 等命令。

当前关闭了 `status_indicator`，因为该插件的状态浮窗在某些 Neovim UI 更新时机会触发 `E565: Not allowed to change text or change window`。关闭后不影响打开 Codex 终端、聚焦窗口和发送选区。

## 前置条件

需要先安装 Codex CLI，并保证 `codex` 命令在 `$PATH` 中可用：

```sh
npm install -g @openai/codex
codex --version
```

如果 Codex CLI 不在默认路径，可以在 `lua/plugins/codex.lua` 中显式指定：

```lua
opts = {
  terminal_cmd = "/path/to/codex",
},
```

## 常用命令

| 操作 | 快捷键 | 命令 | 说明 |
| --- | --- | --- | --- |
| 打开或隐藏 Codex | `<leader>ac` | `:Codex` | 在 Neovim 内打开 Codex 终端，已有窗口时切换显示状态 |
| 续接最近一次会话 | `<leader>ar` | `:CodexOpen resume --last` | 重新打开最近一次交互式 session |
| 聚焦 Codex 窗口 | `<leader>af` | `:CodexFocus` | 光标切到 Codex 终端 |
| 发送选区 | visual 模式 `<leader>as` | `:CodexSend` | 把当前选择的代码发送给 Codex |

插件还支持 `:CodexTreeAdd`，可以从 `neo-tree` 或 `oil.nvim` 这类文件树中把文件加入上下文。当前配置没有给它绑定快捷键，因为这份配置里没有看到 `neo-tree` 或 `oil.nvim` 的使用痕迹。如果以后启用文件树，可以加：

```lua
{
  "<leader>aa",
  "<cmd>CodexTreeAdd<cr>",
  desc = "Codex: Add File",
  ft = { "neo-tree", "oil" },
}
```

## 基本使用流程

1. 在项目根目录打开 Neovim。
2. 按 `<leader>ac` 打开 Codex 终端。
3. 第一次使用时，按 Codex CLI 的提示完成登录或授权。
4. 在普通 buffer 中选择一段代码。
5. visual 模式按 `<leader>as`，把选区发给 Codex。
6. 按 `<leader>af` 回到 Codex 终端，继续补充需求或查看结果。
7. 如果想接回上一次交互，按 `<leader>ar` 或输入 `:CodexOpen resume --last`。

推荐从项目根目录启动 Neovim，这样 Codex CLI 看到的工作目录和当前项目一致，读文件、改文件、跑测试都会更自然。

## 常见工作流

### 解释一段代码

1. 选中函数、配置块或报错附近的代码。
2. 按 `<leader>as` 发送给 Codex。
3. 在 Codex 终端里输入：

```text
解释这段代码的作用，重点说明输入输出、副作用和可能的风险。
```

适合用来理解陌生插件配置、复杂 keymap、autocmd 或 LSP 配置。

### 修改当前文件

1. 打开目标文件。
2. 选中要改的区域，按 `<leader>as`。
3. 在 Codex 终端里说明修改目标，例如：

```text
把这段配置改成更符合 LazyVim 的写法，保持行为不变，并说明改动点。
```

如果改动范围不只当前选区，直接在 Codex 里说明相关文件路径会更可靠，例如：

```text
请修改 lua/plugins/codex.lua，给 CodexTreeAdd 增加一个只在 oil 文件类型生效的快捷键。
```

### 让 Codex 帮你排查启动问题

在 Neovim 中遇到启动报错时，可以把错误信息和相关配置一起给 Codex：

```text
启动 Neovim 时出现下面的错误，请根据这份 LazyVim 配置定位原因，并给出最小修复方案。
```

然后粘贴 `:messages` 里的错误，或选择相关配置块后按 `<leader>as`。

### 配合 quickfix、diagnostics 使用

当 LSP 或 lint 给出报错时，先跳到报错位置，再选中附近代码发送给 Codex。提问时带上约束：

```text
根据当前诊断修复这个问题，不要做无关重构。修复后说明应该运行什么检查。
```

这个提示能减少 Codex 顺手重构周边代码的概率。

## 使用技巧

### 一次只给足够的上下文

不要一开始就把很大的文件整段发送给 Codex。更好的方式是先发送相关函数、错误信息、文件路径和你的目标。上下文越具体，Codex 越容易给出可直接落地的修改。

### 明确限制改动范围

给 Codex 的指令里尽量写清楚边界：

```text
只修改 lua/plugins/codex.lua，不要改 lazy-lock.json 以外的文件。
```

或：

```text
保持现有快捷键不变，只新增一个命令映射。
```

这对配置仓库尤其重要，因为 Neovim 配置通常有很多互相影响的插件。

### 先问方案，再让它改

不确定插件行为时，可以先让 Codex 读代码并给方案：

```text
先不要修改文件。请阅读当前配置，说明要实现这个功能需要改哪些文件，以及可能的风险。
```

确认方案后再让它执行。这样更适合 LSP、completion、formatting 这类容易互相影响的配置。

### 用小步修改降低风险

一次只处理一个目标，例如：

- 先加插件 spec。
- 再加快捷键。
- 再跑 `nvim --headless '+qa'`。
- 最后根据错误修复。

小步修改更容易 review，也更容易回退。

### 给 Codex 明确检查命令

这个仓库常用检查命令：

```sh
stylua --check .
nvim --headless '+qa'
nvim --headless '+Lazy! sync' +qa
```

让 Codex 修改配置时，可以直接要求：

```text
修改后请运行 stylua --check . 和 nvim --headless '+qa'，如果失败，请基于错误继续修复。
```

### 注意 lazy-lock.json

新增插件或同步插件后，`lazy-lock.json` 可能变化。提交前用：

```sh
git diff -- lazy-lock.json
```

确认 lockfile 里是否只包含你预期的插件变更。如果不希望顺手更新所有插件，避免在不需要时运行完整 `:Lazy sync`。

## 可选增强：状态提示

`codex.nvim` 可以通过 Codex CLI 的 notify 机制更准确地显示忙碌状态。当前配置为了避开 `E565` 状态浮窗错误，默认关闭了它。如果以后插件修复了这个问题，可以改成下面的配置思路：

```lua
opts = {
  env = {
    CODEX_NVIM_NOTIFY_PATH = "/tmp/codex.nvim/notify.jsonl",
  },
  status_indicator = {
    cli_notify_path = "/tmp/codex.nvim/notify.jsonl",
    turn_active_timeout_ms = 300000,
    turn_idle_grace_ms = 2000,
    inflight_timeout_ms = 300000,
  },
},
```

Codex CLI 配置中还需要加入 notify 脚本，例如：

```toml
notify = ["sh", "/path/to/codex.nvim/scripts/codex_notify.sh"]
```

这一步不是必须的。当前配置保持最小化，先保证打开终端、发送选区和基础交互可用。

## 故障排查

### `:Codex` 打不开

先检查插件是否安装：

```vim
:Lazy
```

再检查 Codex CLI：

```sh
codex --version
```

### 想接续上次 session

如果你刚关闭或隐藏了 Codex 终端，直接用下面任一方式恢复最近一次交互式会话：

```vim
:CodexOpen resume --last
```

或者按 `<leader>ar`。这个命令对应 Codex CLI 的 `resume --last`，不是新建 session。

如果命令不存在，安装或修正 `$PATH`。

### 打开了终端但 Codex 没有响应

确认当前 shell 能正常运行 `codex`。可以在普通终端中进入项目目录后执行：

```sh
codex
```

如果普通终端也不能用，问题通常在 Codex CLI 登录、网络或环境变量，而不是 Neovim 插件。

### 发送选区没有效果

确认是在 visual 模式下按 `<leader>as`。普通模式下这个快捷键不会触发，因为当前配置只为 visual 模式绑定了 `CodexSend`。

### Codex 改了过多文件

先用 Git 查看变更：

```sh
git status --short
git diff
```

以后提问时给出更明确的范围限制，例如“只修改当前文件”或“不要更新 lockfile”。

## 推荐提示词

```text
请只阅读当前选区，解释它的作用和潜在问题，不要修改文件。
```

```text
请基于当前选区做最小修改，保持现有行为不变，只修复这个错误。
```

```text
请修改这个 Neovim 插件配置，遵循 LazyVim/lazy.nvim 的现有风格，所有 keymap 都要有 desc。
```

```text
请先给出修改计划，不要动文件。计划里列出会修改的文件、原因和验证命令。
```

```text
请完成修改并运行 stylua --check . 和 nvim --headless '+qa'，失败则继续修复。
```
