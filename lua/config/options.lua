-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

local function ensure_ts_ft_to_lang()
  local ok, language = pcall(require, "vim.treesitter.language")
  if not ok or not language or not language.get_lang then
    return
  end

  local function get_lang(ft)
    local lang = language.get_lang(ft)
    return lang or ft
  end

  local lang_module = vim.treesitter and vim.treesitter.language or language
  if lang_module.ft_to_lang == nil then
    function lang_module.ft_to_lang(ft)
      return get_lang(ft)
    end
  end

  if vim.treesitter and vim.treesitter.language == nil then
    vim.treesitter.language = language
  end

  if vim.treesitter and vim.treesitter.language.ft_to_lang == nil then
    vim.treesitter.language.ft_to_lang = lang_module.ft_to_lang
  end

  local parsers_ok, parsers = pcall(require, "nvim-treesitter.parsers")
  if parsers_ok and parsers and parsers.ft_to_lang == nil then
    function parsers.ft_to_lang(ft)
      return get_lang(ft)
    end
  end
end

ensure_ts_ft_to_lang()

vim.api.nvim_create_autocmd("User", {
  pattern = "LazyDone",
  callback = ensure_ts_ft_to_lang,
})

-- don't need spell check
-- opt.spelllang = { "en", "en_us", "cjk" }
opt.spelllang = {}
opt.relativenumber = false -- Relative line numbers
