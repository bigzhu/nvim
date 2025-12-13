# Neovim LazyVim 配置自定义改动报告

## 📊 概览

- **基础**: LazyVim Starter
- **自定义提交**: 6 个
- **修改文件**: 17 个
- **新增代码行**: 427 行

## 🔧 主要自定义改动

### 1. **Obsidian 笔记集成** 📝

**文件**: `lua/plugins/obsidian.lua`

配置了 obsidian.nvim 插件，实现与 Obsidian 笔记系统的无缝集成：

- **工作区配置**: 连接到 `~/Sync/home/cheese` Obsidian 仓库
- **本地开发支持**: 支持通过环境变量 `OBSIDIAN_DEV_DIR` 使用本地开发版本
- **自定义笔记 ID**: 使用 4 个随机大写字母作为笔记 ID
- **URL 处理**: 自动在浏览器打开链接和图片
- **完成度排序**: 按修改时间倒序显示笔记

**快捷键** (`<leader>o*`):

- `<leader>of`: 快速搜索笔记
- `<leader>os`: 按内容搜索
- `<leader>od`: 创建每日笔记
- `<leader>on`: 创建新笔记
- `<leader>ot`: 使用模板创建笔记

---

### 2. **代码运行工具** 🚀

**文件**: `lua/plugins/code_runner.lua`

集成 code_runner.nvim，支持直接在编辑器中运行代码：

- **支持的语言**:
  - Python: `uv run python`
  - Go: `go test`
  - Dart: `flutter test`
  - Markdown: 打开对应的 Obsidian 笔记

- **配置**: 终端在下方，不自动进入插入模式

**快捷键**:

- `<leader>r`: 运行当前代码
- `<leader>R`: 运行 Python 文件并传入参数

---

### 3. **Kitty 终端滚动回溯** 🖥️

**文件**: `lua/plugins/kitty-scrollback.lua`

支持在 Kitty 终端中回溯滚动历史。

---

### 4. **Markdown 工具链** 📄

#### a) **Markdown 目录生成** (`lua/plugins/markdown_toc.lua`)

- 自动生成和更新 Markdown 目录

#### b) **Markdown 格式化** (`lua/plugins/markdown_format.lua`)

- 使用 Prettier/Mdformat 自动格式化
- 让 LazyVim 统一管理 format_on_save

---

### 5. **快捷键自定义** ⌨️

**文件**: `lua/config/keymaps.lua`

大量自定义快捷键和功能：

#### Obsidian 相关

```
<leader>of  - 文件快速搜索
<leader>os  - 内容搜索
<leader>od  - 创建每日笔记
<leader>on  - 创建新笔记
<leader>ot  - 使用模板
v<CR>       - 在可视模式创建链接
```

#### 代码运行

```
<leader>r   - 运行当前代码
<leader>R   - 运行 Python 文件并传入参数
```

#### 终端特殊键位

- `<C-CR>` (Ctrl+Enter) - 特殊快捷键支持
- `<S-CR>` (Shift+Enter) - 特殊快捷键支持

#### 其他

- `<Space>` - 禁用空格默认行为，保留为 Leader 键

---

### 6. **编辑器配置** ⚙️

**文件**: `lua/config/options.lua`

- **Python LSP**: 使用 Pyright（可选切换为 basedpyright）
- **Ruff**: 使用官方 ruff LSP
- **文件类型**: 添加 PineScript 支持

**文件**: `lua/config/autocmds.lua`

自定义自动命令。

---

### 7. **插件管理配置** 📦

**文件**: `lua/plugins/lazy.lua`

自定义主题和 Treesitter 解析器：

- **主题**: Gruvbox
- **Treesitter 解析器**: 添加了 GraphQL、PineScript 等多种语言支持

---

### 8. **LazyExtras 启用** 🎁

**文件**: `lazyvim.json`

启用的 Extras:

- `ai.claudecode` - Claude Code 集成
- `ai.copilot` - GitHub Copilot
- `editor.mini-diff` - 轻量级 diff 可视化
- `lang.json` - JSON 语言支持
- `lang.markdown` - Markdown 语言支持
- `lang.python` - Python 语言支持
- `lang.toml` - TOML 语言支持

---

## 📋 修改文件清单

```
.nvimlog                         (新增)
AGENTS.md                        (新增)
init.lua                         (修改)
lazy-lock.json                   (修改)
lazyvim.json                     (新增配置)
lua/config/autocmds.lua          (新增)
lua/config/keymaps.lua           (新增: 46 行)
lua/config/options.lua           (修改: 13 行)
lua/plugins/code_runner.lua      (新增: 22 行)
lua/plugins/kitty-scrollback.lua (新增: 27 行)
lua/plugins/lazy.lua             (修改: 35 行)
lua/plugins/markdown_format.lua  (新增: 10 行)
lua/plugins/markdown_toc.lua     (新增: 26 行)
lua/plugins/obsidian.lua         (新增: 78 行)
spell/en.utf-8.add               (修改)
spell/en.utf-8.add.spl           (新增)
```

---

## 🎯 功能亮点

1. ✨ **Obsidian 集成**: 完整的笔记管理系统集成
2. 🚀 **代码运行**: 在编辑器中直接运行多种语言代码
3. 🤖 **AI 助手**: 集成 Claude Code 和 Copilot
4. 📝 **Markdown 工具**: 自动目录生成和格式化
5. ⌨️ **丰富快捷键**: 高效的键位映射
6. 🎨 **主题**: Gruvbox 主题配置
7. 🖥️ **终端支持**: Kitty 终端滚动回溯

---

## 📝 提交历史

| 提交      | 说明                                                            |
| --------- | --------------------------------------------------------------- |
| `fdada6f` | add config                                                      |
| `195e8fd` | feat: enable mini-diff LazyExtras for inline diff visualization |
| `c81c594` | fix: remove format_on_save override in conform config           |
| `91c8d53` | update                                                          |
| `6e6d7c4` | chore(config): add plugin configs and assets                    |
| `05363fb` | fix(config): ensure leader and markdown spelllang               |

---

**生成时间**: 2025-12-13
