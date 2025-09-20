local ok, server = pcall(require, "mason-lspconfig.mappings.server")

local M = {}

if not ok then
  function M.get_mason_map()
    return {
      lspconfig_to_package = {},
      package_to_lspconfig = {},
    }
  end
  M.lspconfig_to_package = {}
  M.package_to_lspconfig = {}
  return M
end

function M.get_mason_map()
  return {
    lspconfig_to_package = server.lspconfig_to_package,
    package_to_lspconfig = server.package_to_lspconfig,
  }
end

M.lspconfig_to_package = server.lspconfig_to_package
M.package_to_lspconfig = server.package_to_lspconfig

return M
