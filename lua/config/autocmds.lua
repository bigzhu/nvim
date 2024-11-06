-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- https://github.com/neovim/neovim/issues/4396#issuecomment-1377191592 提供了这个方法
-- vim.cmd('autocmd VimLeave * set guicursor= | call chansend(v:stderr, "\\e[5 q")')
-- 把光标改回 |
-- 没有用, 只要再开 tmux tab, 就是柱子
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  command = 'set guicursor= | call chansend(v:stderr, "\\e[5 q")',
})
