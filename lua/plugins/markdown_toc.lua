return {
  {
    "stevearc/aerial.nvim",
    ft = { "markdown" },
    opts = {
      attach_mode = "global",
      open_automatic = false,
      close_on_select = true,
      layout = {
        min_width = 28,
      },
      filter_kind = false,
    },
    keys = {
      {
        "<leader>ct",
        "<cmd>AerialToggle!<cr>",
        desc = "Toggle Markdown TOC",
      },
    },
  },
}
