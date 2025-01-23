return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    default_component_configs = {
      file_size = {
        enabled = true,
      },
      type = {
        enabled = true,
      },
      last_modified = {
        enabled = true,
      },
    },
    sort_function = function(a, b)
      -- 首先按类型排序（目录最后）
      if a.type ~= b.type then
        return a.type ~= "directory"
      end
      -- 然后按修改时间排序（新的在前）
      local stat_a = require("neo-tree.utils").get_stat(a)
      local stat_b = require("neo-tree.utils").get_stat(b)

      -- 为了调试，打印第一个文件的信息
      -- vim.notify(string.format("File: %s\nStat: %s", a.name, vim.inspect(stat_a)), vim.log.levels.INFO)

      local mtime_a = stat_a and stat_a.mtime and stat_a.mtime.sec or 0
      local mtime_b = stat_b and stat_b.mtime and stat_b.mtime.sec or 0
      return mtime_a > mtime_b
    end,
  },
}
