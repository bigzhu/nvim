return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- https://www.lazyvim.org/extras/coding/nvim-cmp
    -- :LazyExtras 确保安装 coding.nvim-cmp, 这里添加无用
    "hrsh7th/nvim-cmp",
  },
  opts = {
    completion = {
      nvim_cmp = true,
      min_chars = 1,
    },
    preferred_link_style = "markdown",
    workspaces = {
      {
        name = "cheese",
        path = "~/Sync/home/cheese",
      },
    },
  },
}
