return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "html", "tsserver", "tailwindcss" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local _border = "bordered"
			require("lspconfig.ui.windows").default_options = {
				border = _border,
			}
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(client, bufnr)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { bufnr = bufnr })
			end
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			lspconfig.tsserver.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.html.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			lspconfig.tailwindcss.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
	},
}
