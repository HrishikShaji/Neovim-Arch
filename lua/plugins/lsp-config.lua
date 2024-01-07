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
			local _border = "single"
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
			local mason_registry = require("mason-registry")

			local codelldb = mason_registry.get_package("codelldb")
			local extension_path = codelldb:get_install_path() .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
			local rt = require("rust-tools")
			rt.setup({
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path,
						liblldb_path),
				},

				server = {
					capabilities = capabilities,
					on_attach = on_attach,
				},
			})
		end,
	},
}
