return {

	--sample
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				styles = {
					comments = { "italic" },
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
