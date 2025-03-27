return {
	'nvim-treesitter/nvim-treesitter',
	tag = 'v0.9.3',

	opts = {
		ensure_installed = {
			"c", "cpp", "lua", "vim", "vimdoc", "query", "markdown",
			"markdown_inline", "kdl", "toml", "json", "yaml", "hyprlang"
		},

		highlight = {
			enable = true,
		},

		indent = {
			enable = true,
		},
	},

	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)

		vim.filetype.add({
			pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
		})
	end,
}
