-- Optional: suppress noisy LSP position-encoding warning in logs
return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local showMessage = vim.lsp.handlers["window/showMessage"]
      vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
        if params and params.message and params.message:match("position encodings") then
          return
        end
        return showMessage(err, method, params, client_id)
      end
    end,
  },
}
