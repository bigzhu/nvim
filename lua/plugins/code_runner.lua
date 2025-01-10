return {
  {
    "CRAG666/code_runner.nvim",
    config = function()
      require("code_runner").setup({
        filetype = {
          go = "go test $dir",
          dart = "flutter test",
          python = "poetry run python",
          markdown = 'open "obsidian://open?file=$fileNameWithoutExt"',
        },
      })
    end,
  },
}
