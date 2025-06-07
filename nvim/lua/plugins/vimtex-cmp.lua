return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "micangl/cmp-vimtex", -- add cmp-vimtex as dependency of cmp
  },
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    -- local cmp = require("cmp")
    local astrocore = require("astrocore")

    -- insert the vimtex source uniquely into the existing sources
    astrocore.list_insert_unique(opts.sources, { name = "vimtex", priority = 600 })
  end,
}
