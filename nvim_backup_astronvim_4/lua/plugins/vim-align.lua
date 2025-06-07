return {
  {
    "junegunn/vim-easy-align",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["ga"] = { "<cmd>EasyAlign<cr>", desc = "Align" },
            },
            v = {
              ["ga"] = { "<cmd>'<,'>EasyAlign<cr>", desc = "Align" },
            },
          },
        },
      },
    },
  },
}
