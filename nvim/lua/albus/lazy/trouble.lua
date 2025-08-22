return {
	"folke/trouble.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	opts = {}, -- For default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>tT",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>tt",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>ts",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>td",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>tl",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>tq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},

	config = function()
		require("trouble").setup({})

		vim.keymap.set("n", ".t", function()
			require("trouble").next({ skip_groups = true, jump = true })
		end)

		vim.keymap.set("n", ",t", function()
			require("trouble").previous({ skip_groups = true, jump = true })
		end)
	end,
}
