-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set

if vim.g.vscode then
  -- VSCode extension
  -- https://github.com/vscode-neovim/vscode-neovim/issues/176
  -- vim.keymap.set("n", "K", "<cmd>call VSCodeCall('editor.action.showHover')<CR>", { silent = true })
else
  -- Avoid the default space behavior from stealing the leader key timeout
  vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

  -- ordinary Neovim
  vim.keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Search cheese by file name" })
  vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search cheese by content" })
  vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<CR>", { desc = "Cheese create a new daily note" })
  vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Cheese to create a new note" })
  vim.keymap.set("n", "<leader>ot", "o<CR><Esc><cmd>ObsidianTemplate main.md<CR>", { desc = "Using templates" })
  map("v", "<CR>", "<cmd>ObsidianLinkNew<cr>", { desc = "create link" })

  -- 进入 cheese 的 todo 页面
  -- vim.keymap.set("n", "<leader>td", "<cmd>TodoTelescope cwd=~/Sync/home/cheese/<CR>", { desc = "Enter cheese todo" })
  vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { desc = "Run current code" })

  -- 自定义函数：只输入参数运行当前 Python 文件
  local function run_python_with_args()
    local filename = vim.fn.expand("%:t") -- 获取当前文件名
    if vim.bo.filetype ~= "python" then
      vim.notify("Not a Python file", vim.log.levels.WARN)
      return
    end

    vim.ui.input({ prompt = "Arguments: " }, function(args)
      if args then
        local cmd = "uv run python " .. filename .. " " .. args
        require("code_runner.commands").run_from_fn(cmd)
      end
    end)
  end

  vim.keymap.set("n", "<leader>R", run_python_with_args, { desc = "Run Python file with arguments" })

  -- Open link in markdown with Enter key
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
      vim.keymap.set("n", "<CR>", "<cmd>ObsidianFollowLink<CR>",
        { buffer = true, desc = "Open link" })
    end,
  })

  --  make nvim distinguish between <CR> (Enter) and <C-CR> (Ctrl+Enter)
  vim.api.nvim_set_keymap("", "<Esc>[13;5u", "<C-CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<Esc>[13;5u", "<C-CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("", "<Esc>[13;2u", "<S-CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<Esc>[13;2u", "<S-CR>", { noremap = true, silent = true })
end
