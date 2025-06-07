---@type LazySpec
return {
  {
    "mikavilpas/yazi.nvim",
    branch = "main",
    dependencies = {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>ty"] = { function() require("yazi").yazi() end, desc = "Open Yazi" },
            ["<C-y>"] = { "<cmd>Yazi toggle<cr>", desc = "Toggle Yazi" },
          },
        },
      },
    },
  },
}
