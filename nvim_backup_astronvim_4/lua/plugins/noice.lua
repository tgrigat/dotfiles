return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    views = {
      cmdline_popup = { position = { row = 0, col = -2 }, relative = "cursor" },
    },
  },
}
