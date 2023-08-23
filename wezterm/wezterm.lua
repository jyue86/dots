-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.leader = { key = "Space", mods = "ALT" }

-- Colors and Appearance
config.color_scheme = "Night Owl (Gogh)"
config.colors = {
	cursor_fg = "#080808",
	selection_bg = "#82aaff",
	split = "#21c7a8",
}
config.enable_tab_bar = false
config.font_size = 10
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.default_cursor_style = "SteadyBar"

-- Hyperlink rules
config.hyperlink_rules = wezterm.default_hyperlink_rules()

local act = wezterm.action

local function isViProcess(pane)
	-- get_foreground_process_name On Linux, macOS and Windows,
	-- the process can be queried to determine this path. Other operating systems
	-- (notably, FreeBSD and other unix systems) are not currently supported
	return pane:get_foreground_process_name():find("n?vim") ~= nil
	-- return pane:get_title():find("n?vim") ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
	if isViProcess(pane) then
		window:perform_action(
			-- This should match the keybinds you set in Neovim.
			act.SendKey({ key = vim_direction, mods = "ALT" }),
			pane
		)
	else
		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	conditionalActivatePane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
	conditionalActivatePane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
	conditionalActivatePane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
	conditionalActivatePane(window, pane, "Down", "j")
end)

config.keys = {
	-- Multiplexing
	{
		key = "-",
		mods = "ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "|",
		mods = "ALT|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "t",
		mods = "SHIFT|ALT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "F9",
		mods = "ALT",
		action = wezterm.action.ShowTabNavigator,
	},
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
			timeout_milliseconds = 1000,
		}),
	},
	{ key = "h", mods = "ALT", action = act.EmitEvent("ActivatePaneDirection-left") },
	{ key = "j", mods = "ALT", action = act.EmitEvent("ActivatePaneDirection-down") },
	{ key = "k", mods = "ALT", action = act.EmitEvent("ActivatePaneDirection-up") },
	{ key = "l", mods = "ALT", action = act.EmitEvent("ActivatePaneDirection-right") },
	{
		key = "b",
		mods = "ALT",
		action = act.RotatePanes("CounterClockwise"),
	},
	{ key = "n", mods = "ALT", action = act.RotatePanes("Clockwise") },
	{ key = "w", mods = "ALT", action = act.CloseCurrentPane({ confirm = true }) },
	-- Hyperlink
	{
		key = "e",
		mods = "CTRL|ALT",
		action = wezterm.action({
			QuickSelectArgs = {
				patterns = {
					"http?://\\S+",
					"https?://\\S+",
				},
				action = wezterm.action_callback(function(window, pane)
					local url = window:get_selection_text_for_pane(pane)
					wezterm.open_with(url)
				end),
			},
		}),
	},
	{
		key = "z",
		mods = "ALT",
		action = act.TogglePaneZoomState,
	},
}

config.key_tables = {
	resize_pane = {
		{
			key = "h",
			action = act.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "j",
			action = act.AdjustPaneSize({ "Down", 5 }),
		},
		{
			key = "k",
			action = act.AdjustPaneSize({ "Up", 5 }),
		},
		{
			key = "l",
			action = act.AdjustPaneSize({ "Right", 5 }),
		},
		{
			key = "Escape",
			action = "PopKeyTable",
		},
	},
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.7,
}

config.ssh_domains = {
	{
		name = "bwoah",
		remote_address = "circinus-27@ics.uci.edu",
		username = "jpyue",
	},
}

-- config.enable_kitty_keyboard = true

return config
