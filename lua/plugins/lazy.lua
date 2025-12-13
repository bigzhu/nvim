return {
  { "ellisonleao/gruvbox.nvim" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "graphql",
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "pinescript",
        "python",
        "query",
        "regex",
        "sql",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
}
