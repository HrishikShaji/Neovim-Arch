return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = { "lua", "javascript", "typescript", "html", "css", "tsx" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup({
				enable = true,
				enable_close_on_slash = true,
			})
		end,
		lazy = true,
		event = "VeryLazy",
	},
}
