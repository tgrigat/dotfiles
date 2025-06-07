local M = {}

M.config_paths = { "./.nvim-dap/nvim-dap.lua", "./.nvim-dap.lua", "./.nvim/nvim-dap.lua" }

function M.search_project_config()
  local project_config = ""
  for _, p in ipairs(M.config_paths) do
    local f = io.open(p)
    if f ~= nil then
      f:close()
      project_config = p
      break
    end
  end
  if project_config == "" then return end

  -- Use pcall to safely require the file
  local status, result = pcall(function() return dofile(project_config) end)
  if status then
    return result
  else
    vim.notify("Error loading configuration file: " .. project_config, vim.log.levels.ERROR)
  end
end

function M.load_and_apply_config()
  local project_dap_config = M.search_project_config()
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    vim.notify("[nvim-dap-project] Failed to load DAP", vim.log.levels.ERROR)
    return
  end

  if project_dap_config == nil then
    vim.notify("[nvim-dap-project] No project configuration found", vim.log.levels.WARN)
    return
  end

  local config_applied = false

  -- Handle adapters
  if type(project_dap_config.adapters) == "table" then
    for language, adapter in pairs(project_dap_config.adapters) do
      if not dap.adapters[language] then dap.adapters[language] = {} end
      require("astrocore").extend_tbl(dap.adapters[language], adapter)
      config_applied = true
    end
  end

  -- Handle configurations
  if type(project_dap_config.configurations) == "table" then
    for language, configs in pairs(project_dap_config.configurations) do
      if not dap.configurations[language] then dap.configurations[language] = {} end
      require("astrocore").list_insert_unique(dap.configurations[language], configs)
      config_applied = true
    end
  end

  if config_applied then
    vim.notify("[nvim-dap-project] DAP configuration applied successfully", vim.log.levels.INFO)
  else
    vim.notify("[nvim-dap-project] No valid configurations found in project file", vim.log.levels.WARN)
  end
end

return M
