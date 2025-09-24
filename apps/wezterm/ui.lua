local vars = require("vars")
local wezterm = require("wezterm")

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end


return {
  color_scheme = "Gruvbox Material (Gogh)",
  font = wezterm.font("Hack Nerd Font Mono", { weight = "Medium" }),
  font_rules = {
    {
      italic = true,
      font = wezterm.font({
        family = "Hack Nerd Font Mono",
        weight = "DemiBold",
        italic = true,
      }),
    },
  },
  font_size = 16,
  adjust_window_size_when_changing_font_size = false,
  tab_max_width = 18,
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  window_background_opacity = 0.95,
  tab_bar_at_bottom = false,
  use_fancy_tab_bar = true
}
