local dap_config_template = [[
return {
  adapters = {
    -- Add your adapters here
    -- Example:
    -- python = {
    --   type = "executable",
    --   command = "path/to/debugpy/python",
    --   args = { "-m", "debugpy.adapter" },
    -- },
  },
  configurations = {
    -- Add your configurations here
    -- Example:
    -- python = {
    --   {
    --     type = "python",
    --     request = "launch",
    --     name = "Launch file",
    --     program = "${file}",
    --     pythonPath = function()
    --       return "/usr/bin/python"
    --     end,
    --     connect = {
    --      host = "localhost",
    --      port = 5678,
    --     }
    --   },
    -- },
  },
}
]]

return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    commands = {
      RunScriptWithArgs = {
        desc = "Run Script With Args",
        function(t)
          -- :help nvim_create_user_command
          local status_ok, dap = pcall(require, "dap")
          if not status_ok then return {} end
          local args = vim.split(vim.fn.expand(t.args), "\n")
          local approval = vim.fn.confirm(
            "Will try to run:\n    "
              .. vim.bo.filetype
              .. " "
              .. vim.fn.expand "%"
              .. " "
              .. t.args
              .. "\n\n"
              .. "Do you approve? ",
            "&Yes\n&No",
            1
          )
          if approval == 1 then
            dap.run {
              type = vim.bo.filetype,
              request = "launch",
              name = "Launch file with custom arguments (adhoc)",
              program = "${file}",
              args = args,
            }
          end
        end,
      },
      CreateDapConfig = {
        desc = "Create a basic .nvim-dap.lua file",
        function()
          local file_path = ".nvim-dap.lua"
          local file = io.open(file_path, "w")
          if file then
            file:write(dap_config_template)
            file:close()
            vim.notify("Created .nvim-dap.lua file", vim.log.levels.INFO)
          else
            vim.notify("Failed to create .nvim-dap.lua file", vim.log.levels.ERROR)
          end
        end,
      },
    },
    autocmds = {
      custom_dap = {
        {
          event = "VimEnter",
          desc = "Project-wise DAP",
          callback = function() require("user.project-dap").load_and_apply_config() end,
        },
      },
    },
    mappings = {
      n = {
        ["<Leader>dl"] = {
          desc = "Load nvim-dap.lua",
          function() require("user.project-dap").load_and_apply_config() end,
        },
      },
    },
  },
}
