local allowed_hosts = {
  "node",
  "mainframe",
}

local hostname = vim.fn.systemlist("hostname")[1]
local host_allowed = false

for _, host in ipairs(allowed_hosts) do
  if hostname == host then
    host_allowed = true
    break
  end
end

if not host_allowed then return {} end

return {
  "3rd/image.nvim",
  ft = { "markdown", "vimwiki", "norg", "typst" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
        options = {
          g = {
            image_nvim_kitty_protocol = true,
          },
        },
      },
    },
  },
  opts = {
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki" },
      },
      neorg = {
        enabled = false,
        filetypes = { "norg" },
      },
      typst = {
        enabled = false,
        filetypes = { "typst" },
      },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    window_overlap_clear_enabled = false,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    editor_only_render_when_focused = false,
    tmux_show_only_in_active_window = false,
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
  },
}
