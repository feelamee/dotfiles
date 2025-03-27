return {
	"rose-pine/neovim",
	name = "rose-pine",

	opts = {
		variant = 'moon', -- auto, main, moon, or dawn
		dark_variant = 'moon', -- main, moon, or dawn

		styles = {
			transparency = true,
		},
	},

	config = function(_, opts)
		require('rose-pine').setup(opts)
		vim.cmd.colorscheme('rose-pine')
	end

}
