return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = false, -- only works on Windows for hidden files/directories
        hide_by_name = {
          -- "node_modules"
        },
        hide_by_pattern = { -- uses glob style patterns
          "*.g.dart",
          -- "*.meta",
          -- "*/src/*.ts",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          -- ".gitignored",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          -- ".DS_Store",
          -- "thumbs.db"
        },
        never_show_by_pattern = { -- uses glob style patterns
          -- ".null-ls_*",
        },
      },
    },

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
      -- 安全检查：确保节点有必要的字段
      if not a or not b then
        return false
      end
      
      local a_name = a.name or ""
      local b_name = b.name or ""
      local a_type = a.type or "file"
      local b_type = b.type or "file"
      
      -- 首先按类型排序（目录在前）
      if a_type ~= b_type then
        return a_type == "directory"
      end
      
      -- 然后按名称排序（字母顺序）
      return a_name:lower() < b_name:lower()
    end,
  },
}
