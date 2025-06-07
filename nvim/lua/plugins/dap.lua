local function split_string(inputstr, sep)
  if sep == nil then sep = "%s" end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local dap_config_template = [[
return {
	configurations = {
		-- python = {
		-- 	{
		-- 		name = "Attach to Command",
		-- 		type = "python_ext",
		-- 		request = "attach",
		-- 		command_str ="python3 -m debugpy --listen localhost:5678 hello.py",
		-- 		port = 5678
		-- 	},
		-- },
	},
}
]]

return {
  {
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
          ["<Leader>`"] = {
            desc = "Debugmaster Mode Toggle",
            function()
              require("debugmaster").mode.toggle()
              local current_status_message
              if require("debugmaster.debug.mode").is_active() then -- Check the new state
                current_status_message = "Debug Mode: ON"
              else
                current_status_message = "Debug Mode: OFF"
              end
              vim.notify(current_status_message, vim.log.levels.INFO)
            end,
          },
          ["<Leader>dd"] = {
            desc = "Debugmaster Mode Toggle",
            function()
              require("debugmaster").mode.toggle()
              local current_status_message
              if require("debugmaster.debug.mode").is_active() then -- Check the new state
                current_status_message = "Debug Mode: ON"
              else
                current_status_message = "Debug Mode: OFF"
              end
              vim.notify(current_status_message, vim.log.levels.INFO)
            end,
          },
          ["<Leader>ds"] = {
            desc = "show dap log",
            function()
              local log = require "dap.log"
              log.create_logger "dap.log"
              local current_tab = vim.fn.tabpagenr()

              -- Get the first logger to use for the initial tab creation
              local first_logger = nil
              for _, logger in pairs(log._loggers) do
                first_logger = logger
                break
              end

              if first_logger then
                -- Create new tab with the first log file
                vim.cmd("tabnew " .. first_logger._path)
                vim.bo.modifiable = false
                vim.api.nvim_buf_set_keymap(0, "n", "q", ":q<CR>", { noremap = true, silent = true })

                -- Add the rest of the log files as splits
                local is_first = true
                for _, logger in pairs(log._loggers) do
                  if not is_first then
                    vim.cmd.split(logger._path)
                    vim.bo.modifiable = false
                    vim.api.nvim_buf_set_keymap(0, "n", "q", ":q<CR>", { noremap = true, silent = true })
                  end
                  is_first = false
                end

                -- Switch back to the original tab
                vim.cmd("tabnext " .. current_tab)
              else
                vim.notify("No DAP log files found", vim.log.levels.INFO)
              end
            end,
          },
        },
      },
    },
  },
  {
    "rebelot/heirline.nvim",
    opts = function(_, hl_opts)
      local status_util = require "astroui.status.utils"
      local config = assert(require("astroui").config.status)
      local provider = require "astroui.status.provider"
      local component_builder = require("astroui.status.component").builder

      ---@class astroui.status.provider
      provider.debugmode = function(opts)
        local extend_tbl = require("astrocore").extend_tbl
        opts = extend_tbl(vim.tbl_get(config, "providers", "debugmode"), opts)

        return function()
          local text = ""
          if require("debugmaster.debug.mode").is_active() then text = "DEBUG" end

          status_util.stylize(text, opts)
        end
      end

      local component = component_builder(status_util.setup_providers({ debugmode = {} }, { "debugmode" }))

      -- TODO: fix this component. Currently it directly breaks the first mode component.
      hl_opts.statusline = require("astrocore").extend_tbl(hl_opts.statusline, {})
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function(plugin, opts)
      -- run default AstroNvim nvim-dap-ui configuration function
      require "astronvim.plugins.configs.nvim-dap-ui"(plugin, opts)

      -- disable dap events that are created
      local dap = require "dap"
      dap.listeners.after.event_initialized.dapui_config = nil
      dap.listeners.before.event_terminated.dapui_config = nil
      dap.listeners.before.event_exited.dapui_config = nil
    end,
  },
  {
    "miroshQa/debugmaster.nvim",
  },
  {
    "mfussenegger/nvim-dap",
    config = function(opts)
      local dap = require "dap"
      dap.set_log_level "INFO"
      dap.adapters.python_ext = function(cb, config)
        local parts = split_string(config.command_str, " ")
        local command = table.remove(parts, 1)
        local args = parts

        if config.request == "attach" then
          local port = config.port or 5678
          local host = config.host or "127.0.0.1"

          cb {
            type = "server",
            host = host,
            port = port,
            executable = {
              command = command,
              args = args,
            },
            options = {
              source_filetype = "python",
            },
          }
        else
          vim.notify("No launch request implemented for the `python_ext` adapter yet.", vim.log.levels.ERROR)
        end
      end
    end,
  },
}
