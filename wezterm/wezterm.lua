-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}
local act = wezterm.action
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:

config.font = wezterm.font("Iosevka Term")
-- config.term="wezterm"

-- for i = 1, 8 do
--   -- CTRL+ALT + number to activate that tab
--   table.insert(config.keys, {
--     key = tostring(i),
--     mods = 'ALT',
--     action = act.ActivateTab(i - 1),
--   })
-- end

config.front_end = "OpenGL"


config.keys = {
  {
    key = "1",
    mods = "ALT",
    action = wezterm.action.ActivateTab(0),
  },
  {
    key = "2",
    mods = "ALT",
    action = wezterm.action.ActivateTab(1),
  },
  {
    key = "3",
    mods = "ALT",
    action = wezterm.action.ActivateTab(2),
  },
  {
    key = "4",
    mods = "ALT",
    action = wezterm.action.ActivateTab(3),
  },
  {
    key = "5",
    mods = "ALT",
    action = wezterm.action.ActivateTab(4),
  },
  {
    key = "6",
    mods = "ALT",
    action = wezterm.action.ActivateTab(5),
  },
  {
    key = "7",
    mods = "ALT",
    action = wezterm.action.ActivateTab(6),
  },
  {
    key = "8",
    mods = "ALT",
    action = wezterm.action.ActivateTab(7),
  },
  {
    key = "9",
    mods = "ALT",
    action = wezterm.action.SplitPane {
      direction = "Right",
      size = { Percent = 50 }
    },
  },
  {
    key = "0",
    mods = "ALT",
    action = wezterm.action.SplitPane {
      direction = "Down",
      size = { Percent = 50 }
    },
  },
  {
    key = "h",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivatePaneDirection "Left",
  },
  {
    key = 'i',
    mods = 'CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = "j",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivatePaneDirection "Down",
  },
  {
    key = "k",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivatePaneDirection "Up",
  },
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivatePaneDirection "Right",
  },
  {
    key = "R",
    mods = "CTRL|SHIFT",
    action = wezterm.action.RotatePanes "Clockwise",
  },
  {
    key = "Enter",
    mods = "ALT",
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = "Insert",
    mods = "SHIFT",
    action = wezterm.action.PasteFrom "Clipboard",
  },
  {
    key = "Insert",
    mods = "CTRL",
    action = wezterm.action.CopyTo "Clipboard",
  },
  {
    key = "Insert",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PasteFrom "PrimarySelection",
  },
}

-- config.color_scheme = 'ayu'
-- config.color_scheme = 'nord'
-- config.color_scheme = 'Ayu Mirage'
config.color_scheme = 'Tokyo Night'
config.color_scheme = 'MaterialDark'
config.enable_kitty_graphics = true
config.font_size = 11.0
-- config.color_scheme = 'nord'

-- and finally, return the configuration to wezterm
return config
