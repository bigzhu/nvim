return {
  {
    "stevearc/aerial.nvim",
    ft = { "markdown" },
    opts = {
      attach_mode = "global",
      -- Only auto-open the TOC when working on markdown buffers
      open_automatic = function(bufnr)
        bufnr = bufnr or vim.api.nvim_get_current_buf()
        return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].filetype == "markdown"
      end,
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
