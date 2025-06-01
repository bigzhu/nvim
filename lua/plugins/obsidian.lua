return {
  -- "epwalsh/obsidian.nvim",
  dir = "~/Sync/Projects/obsidian.nvim",
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
        -- vim.notify("first title : " .. title, vim.log.levels.INFO)
        -- 移除末尾的空白字符和不可见字符
        suffix = vim.fn.trim(title)
        -- :gsub(" ", "-")      -- 空格转连字符
        -- :gsub("[\n\r]+", "") -- 移除换行
        -- :gsub("[<>:\"/\\|?*]+", "-") -- 移除非法字符
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      -- vim.notify("Final suffix: " .. suffix, vim.log.levels.INFO)
      return suffix
    end,
    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    ---@param url string
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      -- vim.fn.jobstart({ "open", url }) -- Mac OS
      -- vim.fn.jobstart({"xdg-open", url})  -- linux
      -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      vim.ui.open(url) -- need Neovim 0.10.0+
    end,
    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
    -- file it will be ignored but you can customize this behavior here.
    ---@param img string
    follow_img_func = function(img)
      -- Get the current buffer's directory as base path
      local current_file = vim.fn.expand("%:p:h")
      local abs_path = current_file .. "/" .. img
      abs_path = vim.fn.expand(abs_path)

      vim.fn.jobstart({ "open", abs_path }) -- Mac OS
      -- vim.notify("Opening image: " .. abs_path, vim.log.levels.INFO)
      -- vim.fn.jobstart({ "qlmanage", "-p", abs_path }) -- Mac OS quick look preview
      -- vim.fn.jobstart({ "kitty", "+kitten", "icat", abs_path })
      -- vim.fn.jobstart({"xdg-open", url})  -- linux
      -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
    end,
  },
}
