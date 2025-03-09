local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	{ "christoomey/vim-tmux-navigator" },
	{ "farmergreg/vim-lastplace" },
	{ "jessarcher/vim-heritage" },
	{ "jwalton512/vim-blade" },
	{ "karb94/neoscroll.nvim", config = true },
	{ "nelstrom/vim-visual-star-search" },
	{ "tpope/vim-eunuch" },
	{ "tpope/vim-fugitive", dependencies = "tpope/vim-rhubarb" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-sleuth" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-unimpaired", event = "VeryLazy" },
	{ "whatyouhide/vim-textobj-xmlattr", dependencies = "kana/vim-textobj-user" },
	{ "windwp/nvim-autopairs", config = true },

	{ import = "user.plugins.barbecue" },
	{ import = "user.plugins.bufdelete" },
	-- { import = "user.plugins.bufferline" },
	{ import = "user.plugins.cmp" },
	{ import = "user.plugins.colorizer" },
	{ import = "user.plugins.conform" },
	{ import = "user.plugins.copilot" },
	{ import = "user.plugins.dashboard-nvim" },
	{ import = "user.plugins.floaterm" },
	{ import = "user.plugins.gitsigns" },
	{ import = "user.plugins.indent-blankline" },
	{ import = "user.plugins.illuminate" },
	{ import = "user.plugins.lazydev" },
	{ import = "user.plugins.lspconfig" },
	{ import = "user.plugins.lualine" },
	{ import = "user.plugins.neo-tree" },
	{ import = "user.plugins.nvim-scrollbar" },
	{ import = "user.plugins.phpactor" },
	{ import = "user.plugins.projectionist" },
	{ import = "user.plugins.rainbow-delimiters" },
	{ import = "user.plugins.telescope" },
	{ import = "user.plugins.todo-comments" },
	{ import = "user.plugins.treesj" },
	{ import = "user.plugins.treesitter" },
	{ import = "user.plugins.tokyonight" },
	{ import = "user.plugins.vim-commentary" },
	{ import = "user.plugins.vim-pasta" },
	{ import = "user.plugins.vim-rooter" },
	{ import = "user.plugins.vim-test" },
	{ import = "user.plugins.whichkey" },
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
