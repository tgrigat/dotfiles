return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        neovide_config = {
          {
            event = { "UIEnter", "FocusGained" },
            desc = "Apply Neovide configuration",
            callback = function()
              if vim.g.neovide then
                -- Options
                vim.o.guifont = "Iosevka Nerd Font Mono:h12"
                vim.g.neovide_cursor_animation_length = 0.07
                vim.g.neovide_cursor_trail_size = 0.6
                vim.g.neovide_cursor_smooth_blink = true
                vim.g.neovide_scroll_animation_length = 0.2
                vim.g.neovide_input_ime = true
                vim.g.neovide_transparency = 0.98
                vim.g.neovide_cursor_vfx_mode = "railgun"

                -- Keymaps
                local function paste_from_clipboard() vim.api.nvim_paste(vim.fn.getreg "+", true, -1) end

                local modes = { "n", "v", "s", "x", "o", "i", "l", "c", "t" }
                for _, mode in ipairs(modes) do
                  vim.keymap.set(mode, "<C-S-V>", paste_from_clipboard, { desc = "Paste from clipboard" })
                end
              end
            end,
          },
        },
      },
    },
  },
}
