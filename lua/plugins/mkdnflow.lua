return {
  {
    "jakewvincent/mkdnflow.nvim",
    -- dir = "~/git/mkdnflow.nvim",
    -- rocks = "luautf8", -- Ensures optional luautf8 dependency is installed
    -- luarocks install luautf8
    config = function()
      require("mkdnflow").setup({
        links = {
          -- style = "markdown",
          name_is_source = true,
          conceal = true, -- 隐藏链接
          context = 1,
          implicit_extension = "md",
          -- transform_implicit = false,
          transform_explicit = function(input)
            return input
          end,
        },
        mappings = {
          MkdnFoldSection = { "n", "<leader>q" },
        },
      })
    end,
    lazy = false,
  },
}
