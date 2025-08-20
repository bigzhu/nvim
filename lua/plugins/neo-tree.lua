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
      -- 首先按类型排序（目录在前）
      if a.type ~= b.type then
        return a.type == "directory"
      end
      -- 然后按名称排序（字母顺序）
      return a.name:lower() < b.name:lower()
    end,
  },
}
