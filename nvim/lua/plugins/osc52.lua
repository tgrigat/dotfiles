-- Check if conditions are met for OSC 52
if true then return {} end

if
  vim.fn.getenv "KONSOLE_DBUS_SERVICE" == vim.NIL
  and vim.fn.getenv "KONSOLE_DBUS_SESSION" == vim.NIL
  and vim.fn.getenv "KONSOLE_VERSION" == vim.NIL
then
  return {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.g = opts.options.g or {}
      opts.options.g.clipboard = {
        name = "OSC 52",
        copy = {
          ["+"] = require("vim.ui.clipboard.osc52").copy "+",
          ["*"] = require("vim.ui.clipboard.osc52").copy "*",
        },
        paste = {
          ["+"] = require("vim.ui.clipboard.osc52").paste "+",
          ["*"] = require("vim.ui.clipboard.osc52").paste "*",
        },
      }
      return opts
    end,
  }
end

-- Return an empty table if conditions are not met
