-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "lua",
      "vim",
      "beancount"
      -- add more arguments for adding more treesitter parsers
    })
    opts.highlight.disable = require("astrocore").list_insert_unique(opts.highlight.disable, {
      "markdown",
    })
  end,
}
