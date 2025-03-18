return {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,

	opts = {
		flavour = "mocha",
	},

	config = function(plugin, opts)
		require("catppuccin").setup(opts)
		vim.cmd("colorscheme catppuccin")
	end,
}
