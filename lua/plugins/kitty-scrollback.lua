return {
  "mikesmithgh/kitty-scrollback.nvim",
  enabled = true,
  lazy = true,
  cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth", "KittyScrollbackGenerateCommandLineEditing" },
  event = { "User KittyScrollbackLaunch" },
  -- version = '*', -- latest stable version, may have breaking changes if major version changed
  -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
  config = function()
    require("kitty-scrollback").setup({
      {
        paste_window = {
          yank_register_enabled = false,
        },
        -- 设置解决退出时保存提示的问题
        callbacks = {
          after_ready = function()
            -- 设置缓冲区为只读和未修改状态，避免保存提示
            vim.bo.readonly = true
            vim.bo.modified = false
            vim.bo.modifiable = false
          end,
        },
      },
    })
  end,
}
