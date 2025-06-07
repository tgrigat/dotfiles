return {
  "stevearc/overseer.nvim",
  opts = {
    templates = { "builtin", "user.cpp_build", "user.run_script" },
  },
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local prefix = "<Leader>r"
        local default_prefix = "<Leader>M"
        maps.n[prefix] = { desc = require("astroui").get_icon("Overseer", 1, true) .. "Overseer" }
        maps.n[default_prefix] = {}

        maps.n[prefix .. "t"] = { "<Cmd>OverseerToggle<CR>", desc = "Toggle Overseer" }
        maps.n[default_prefix .. "t"] = {}

        maps.n[prefix .. "c"] = { "<Cmd>OverseerRunCmd<CR>", desc = "Run Command" }
        maps.n[default_prefix .. "c"] = {}

        maps.n[prefix .. "r"] = { "<Cmd>OverseerRun<CR>", desc = "Run Task" }
        maps.n[default_prefix .. "r"] = {}

        maps.n[prefix .. "q"] = { "<Cmd>OverseerQuickAction<CR>", desc = "Quick Action" }
        maps.n[default_prefix .. "q"] = {}

        maps.n[prefix .. "a"] = { "<Cmd>OverseerTaskAction<CR>", desc = "Task Action" }
        maps.n[default_prefix .. "a"] = {}

        maps.n[prefix .. "i"] = { "<Cmd>OverseerInfo<CR>", desc = "Overseer Info" }
        maps.n[default_prefix .. "i"] = {}

        -- remove the default mappings
      end,
    },
  },
}
