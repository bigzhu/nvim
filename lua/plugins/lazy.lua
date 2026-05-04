return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  -- Configure LazyVim to load gruvbox-material
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "graphql",
        "pinescript",
        "regex",
        "sql",
        "tsx",
        "typescript",
        "vim",
      },
    },
  },
  -- Display images in Neovim
  {
    "3rd/image.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = false,
        },
      },
    },
  },
}
