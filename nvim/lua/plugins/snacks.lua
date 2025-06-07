-- lazy.nvim
return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    local is_headless_or_neovide = function()
      local uis = vim.api.nvim_list_uis()
      -- If no UIs are attached (headless), disable scrolling as per the new requirement.
      if #uis == 0 then return true end

      for _, ui in ipairs(uis) do
        -- Wrap in pcall in case ui.chan is invalid or get_chan_info fails
        local success, chan_info = pcall(vim.api.nvim_get_chan_info, ui.chan)
        if
          success
          and chan_info
          and chan_info.client
          and chan_info.client.name
          and chan_info.client.name == "neovide"
        then
          -- Neovide is detected, disable scrolling
          return true
        end
      end
      return false
    end
    if not opts.scroll then opts.scroll = {} end
    opts.scroll.enabled = not is_headless_or_neovide()
    opts.indent = { animate = { enabled = true } }
    opts.dim = { animate = { enabled = true } }
  end,
}
