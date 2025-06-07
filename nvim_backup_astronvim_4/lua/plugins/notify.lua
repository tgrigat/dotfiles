---@type LazyPluginSpec
return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    render = "compact",
    stages = "static",
    top_down = true,
    timeout = 1000
  },
}
