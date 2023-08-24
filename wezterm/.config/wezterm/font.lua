local wezterm = require("wezterm")

return {
	{
		intensity = 'Normal',
		italic = true,
		font = wezterm.font {
			family = "PragmataPro Mono Liga",
			harfbuzz_features = { 'ss06=1' }
		}
	},
	{
		intensity = 'Bold',
		italic = true,
		font = wezterm.font {
			family = "PragmataPro Mono Liga",
			harfbuzz_features = { 'ss07=1' }
		}
	}
}
