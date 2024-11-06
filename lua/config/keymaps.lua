-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
if vim.g.vscode then
  -- VSCode extension
  -- https://github.com/vscode-neovim/vscode-neovim/issues/176
  -- vim.keymap.set("n", "K", "<cmd>call VSCodeCall('editor.action.showHover')<CR>", { silent = true })
else
  -- ordinary Neovim
  vim.keymap.set("n", "<C-f>", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Search cheese by file name" })
  vim.keymap.set("n", "<C-j>", "<cmd>ObsidianSearch<CR>", { desc = "Search cheese by content" })
  vim.keymap.set("n", "<C-g>", "<cmd>ObsidianToday<CR>", { desc = "Cheese create a new daily note" })
  vim.keymap.set("n", "<C-t>", "o<CR><Esc><cmd>ObsidianTemplate main.md<CR>", { desc = "Using templates" })

  -- 进入 cheese 的 todo 页面
  -- vim.keymap.set("n", "<leader>td", "<cmd>TodoTelescope cwd=~/Sync/home/cheese/<CR>", { desc = "Enter cheese todo" })
  vim.keymap.set("n", "<leader>r", ":RunCode<CR>", { desc = "Run current code" })

  --  make nvim distinguish between <CR> (Enter) and <C-CR> (Ctrl+Enter)
  vim.api.nvim_set_keymap("", "<Esc>[13;5u", "<C-CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<Esc>[13;5u", "<C-CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("", "<Esc>[13;2u", "<S-CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<Esc>[13;2u", "<S-CR>", { noremap = true, silent = true })
end
