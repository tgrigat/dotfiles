local allowed_hostnames = {
  "node",
  -- Add more hostnames as needed
}

if not vim.tbl_contains(allowed_hostnames, vim.fn.hostname()) then return {} end

local website_configs = {
  {
    pattern = "leetcode.com",
    filetype = "cpp",
  },
  {
    pattern = "github.com",
    filetype = "markdown",
    additional_settings = function()
      vim.bo.textwidth = 80 -- Set text width to 80 characters for GitHub markdown
      vim.bo.spell = true -- Enable spell checking for markdown
    end,
  },
  -- Add more configurations here
  -- {
  --   pattern = "example.com",
  --   filetype = "python",
  --   additional_settings = function()
  --     -- Add any additional settings here
  --   end,
  -- },
}

return {
  "subnut/nvim-ghost.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    vim.g.nvim_ghost_super_quiet = 1 -- Suppress all messages

    vim.api.nvim_create_augroup("nvim_ghost_user_autocommands", { clear = true })

    for _, config in ipairs(website_configs) do
      vim.api.nvim_create_autocmd("User", {
        group = "nvim_ghost_user_autocommands",
        pattern = config.pattern,
        callback = function()
          vim.bo.filetype = config.filetype
          if config.additional_settings then config.additional_settings() end
        end,
      })
    end
  end,
}
