-- Override VenvSelect configuration to remove branch specification
-- This fixes the error: "VenvSelect is now using `main` as the updated branch again. Please remove `branch = regexp` from your config."

return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    branch = "main", -- Explicitly set to main branch
    opts = {
      -- Support for uv projects
      sources = { "venv", "pyenv", "conda", "system" },
      search_venv_managers = { "uv", "poetry", "pipenv" },
    },
  },
  
  -- Configure nvim-dap-python for uv projects
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      local function get_python_path()
        -- Check if we're in a uv project (has pyproject.toml and .venv)
        local cwd = vim.fn.getcwd()
        local pyproject_toml = cwd .. "/pyproject.toml"
        local venv_dir = cwd .. "/.venv"
        
        if vim.fn.filereadable(pyproject_toml) == 1 and vim.fn.isdirectory(venv_dir) == 1 then
          -- This is likely a uv project, use the local .venv python
          local uv_python = cwd .. "/.venv/bin/python"
          if vim.fn.executable(uv_python) == 1 then
            return uv_python
          end
        end
        
        -- Try to get uv python path dynamically
        local uv_python = vim.fn.system("uv run which python 2>/dev/null"):gsub("\n", "")
        if vim.v.shell_error == 0 and uv_python ~= "" and vim.fn.executable(uv_python) == 1 then
          return uv_python
        end
        
        -- Fallback to Mason debugpy
        return vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      end
      
      local python_path = get_python_path()
      require("dap-python").setup(python_path)
      
      -- Configure debugging for uv projects
      require("dap-python").test_runner = "pytest"
      
      -- Add custom debug configurations for uv projects
      table.insert(require("dap").configurations.python, {
        type = "python",
        request = "launch",
        name = "Launch with uv",
        program = "${file}",
        python = function()
          return get_python_path()
        end,
        console = "integratedTerminal",
        cwd = "${workspaceFolder}",
      })
    end,
  },
}
