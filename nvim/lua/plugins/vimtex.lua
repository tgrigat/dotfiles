return {
  "lervag/vimtex",
  dependencies = {
    "AstroNvim/astrocore",
    opts = {
      options = {
        g = {
          vimtex_view_method = "zathura_simple",
          -- vimtex_view_method = "sioyek",
          vimtex_callback_progpath = "/usr/bin/nvim",
        },
      },
    },
  },
}
