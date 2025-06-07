return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      width = 60,
      row = nil,
      col = nil,
      pane_gap = 4,
      autokeys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
      preset = {
        keys = {
          {
            icon = " ",
            key = "s",
            desc = "Restore Session",
            action = ":lua require('resession').load(vim.fn.getcwd(), {dir= 'dirsession', silence_errors = true})",
          },
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
██      ██    ██ ███    ███ ███████ ███    ██ ███████
██      ██    ██ ████  ████ ██      ████   ██ ██     
██      ██    ██ ██ ████ ██ █████   ██ ██  ██ ███████
██      ██    ██ ██  ██  ██ ██      ██  ██ ██      ██
███████  ██████  ██      ██ ███████ ██   ████ ███████

           ███    ██ ██    ██ ██ ███    ███
           ████   ██ ██    ██ ██ ████  ████
           ██ ██  ██ ██    ██ ██ ██ ████ ██
           ██  ██ ██  ██  ██  ██ ██  ██  ██
           ██   ████   ████   ██ ██      ██
          ]],
      },
      -- item field formatters
      formats = {
        footer = { "%s", align = "center" },
        header = { "%s", align = "left" },
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ":~")
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ":h")
            local file = vim.fn.fnamemodify(fname, ":t")
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. "/…" .. file
            end
          end
          local dir, file = fname:match "^(.*)/(.+)$"
          return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        end,
      },
      sections = {
        { section = "header" },
        -- {
        --   pane = 2,
        --   section = "terminal",
        --   cmd = "lazygit",
        --   height = 5,
        --   padding = 1,
        -- },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "Git Status",
          section = "terminal",
          enabled = function()
            local Snacks = require "snacks"
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
  },
}
