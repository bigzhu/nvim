local dev_dir = vim.env.OBSIDIAN_DEV_DIR and vim.fn.expand(vim.env.OBSIDIAN_DEV_DIR) or nil
local use_local = dev_dir and vim.fn.isdirectory(dev_dir) == 1
local ws_path = vim.env.OBSIDIAN_DIR or "~/Sync/home/cheese"

local function open_external(target)
  -- Prefer Neovim 0.10+ API if available
  if vim.ui and vim.ui.open then
    pcall(vim.ui.open, target)
    return
  end
  local sys = (vim.uv or vim.loop).os_uname().sysname
  if sys == "Darwin" then
    vim.fn.jobstart({ "open", target }, { detach = true })
  elseif sys == "Windows_NT" then
    vim.fn.jobstart({ "cmd.exe", "/c", "start", "", target }, { detach = true })
  else
    vim.fn.jobstart({ "xdg-open", target }, { detach = true })
  end
end

local spec = {
  version = "*",
  lazy = true,
  ft = { "markdown" },
  cmd = {
    "ObsidianQuickSwitch",
    "ObsidianSearch",
    "ObsidianToday",
    "ObsidianNew",
    "ObsidianTemplate",
    "ObsidianFollowLink",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  opts = {
    -- Disable builtin nvim-cmp integration; this setup uses blink.cmp instead.
    completion = { nvim_cmp = false, min_chars = 1 },
    preferred_link_style = "markdown",
    sort_by = "modified",
    sort_reversed = true,
    workspaces = {
      { name = "cheese", path = ws_path },
    },
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = vim.fn.trim(title)
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return suffix
    end,
    ---@param url string
    follow_url_func = function(url)
      open_external(url)
    end,
    ---@param img string
    follow_img_func = function(img)
      local current_file = vim.fn.expand("%:p:h")
      local abs_path = vim.fn.expand(current_file .. "/" .. img)
      open_external(abs_path)
    end,
  },
}

if use_local then
  spec.dir = dev_dir
else
  spec[1] = "epwalsh/obsidian.nvim"
end

return spec
