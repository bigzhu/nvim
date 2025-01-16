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
    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    ---使用 title 作为 node 的文件名
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      -- return tostring(os.time()) .. "-" .. suffix
      return suffix
    end,
    mappings = {
      -- 在visual模式下按回车键时创建链接
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
  },
}
