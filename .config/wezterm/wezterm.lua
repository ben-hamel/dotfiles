local wezterm = require("wezterm")
config = wezterm.config_builder()

config ={
	automatically_reload_config = true,
	default_cursor_style = "BlinkingBar",
	font = 	wezterm.font("JetBrainsMono Nerd Font", {weight="Regular", stretch="Normal", style="Normal"}),
	font_size = 12.5,
	color_scheme = 'Aura (Gogh)',
	-- color_scheme = 'lovelace',
	-- color_scheme = 'Catppuccin Mocha (Gogh)'
	-- color_scheme = 'Github Dark',
	-- background = {
		-- {
		-- 	source = {
		-- 		FromFile = {
		-- 			path = "~/.config/wezterm/background.png",
		-- 		},
		-- 	},
		-- 	width = "100%",
		-- 	height = "100%",
		-- 	opacity = 1.0,
		-- }
		-- {
		-- 	source = {
		-- 		Color = "#191414",
		-- 	},
		-- 	width = "100%",
		-- 	height = "100%",
		-- 	-- opacity = 0.75,
		-- }
	-- }
	
}

return config