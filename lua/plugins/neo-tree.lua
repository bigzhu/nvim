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
      -- -- 首先按类型排序（目录在前）
      -- if a.type ~= b.type then
      --   return a.type == "directory"
      -- end
      -- 然后按修改时间排序（新的在前）
      local atime = a.last_modified or 0
      local btime = b.last_modified or 0
      return atime > btime
    end,
  },
}
