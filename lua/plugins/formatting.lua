-- 自定义格式化
return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    -- 为特定文件类型设置格式化工具
    formatters_by_ft = {
      -- 添加或修改你想要的文件类型格式化器
      --   lua = { "stylua" },
      -- 例如添加 JavaScript 和 TypeScript 的格式化器
      --   javascript = { "prettier" },
      --   typescript = { "prettier" },
      --   pip3 install nginxfmt
      nginx = { "nginxfmt" },
      -- 添加 Python 的格式化器
      --   python = { "black" },
      -- 添加 markdown 格式化
      --   markdown = { "prettier" },
      -- 添加 json 格式化
      --   json = { "prettier" },
    },
  },
}
