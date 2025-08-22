return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"stevearc/conform.nvim",
		"j-hui/fidget.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local lspkind = require("lspkind")

		-- Mason setup
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "pylsp", "harper_ls", "clangd" },
		})

		require("fidget").setup({})

		-- Capabilities for autocompletion
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		-- Configure each server using the new vim.lsp.config API
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = { format = { enable = true } },
			},
		})

		-- Pylsp Config – enable desired plugins
		vim.lsp.config("pylsp", {
			capabilities = capabilities,
			settings = {
				pylsp = {
					plugins = {
						pyflakes = { enabled = true }, -- linting
						pycodestyle = { enabled = true }, -- style checks (PEP8)
						mccabe = { enabled = true }, -- complexity checker
						yapf = { enabled = false }, -- optional formatter
						autopep8 = { enabled = false }, -- optional formatter
					},
				},
			},
		})

		-- Completion
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol",
					maxwidth = { menu = 50, abbr = 50 },
					ellipsis_char = "...",
					show_labelDetails = true,
				}),
			},
		})

		-- Formatting via Conform
		require("conform").setup({
			formatters_by_ft = {
				python = { "black" },
				lua = { "stylua" },
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, { desc = "Format file" })

		-- Diagnostics settings
		vim.diagnostic.config({
			update_in_insert = false,
			severity_sort = true,
			underline = true,
			virtual_text = {
				severity = { min = vim.diagnostic.severity.WARN },
				spacing = 2,
				prefix = "●",
			},
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = " ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			float = { border = "rounded", source = "always" },
		})
	end,
}
