return {
  {
    "CRAG666/code_runner.nvim",
    config = function()
      require("code_runner").setup({
        filetype = {
          go = "go test $dir",
          dart = "flutter test",
          python = "uv run python",
          markdown = 'open "obsidian://open?file=$fileNameWithoutExt"',
        },
        mode = "term",
        startinsert = false, -- 不自动进入插入模式
        focus = false, -- 运行后不保持焦点在终端
        term = {
          position = "bot",
          size = 15,
        },
      })
    end,
  },
}
