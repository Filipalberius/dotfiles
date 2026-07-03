return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		input = { enabled = true },
		picker = {
			enabled = true,
			sources = {
				explorer = {
					hidden = true,
				},
			},
		},
        explorer = { enabled = true },
        lazygit = { enabled = true },
		dashboard = {
			enabled = true,
			example = "advanced",
		},
	},
	keys = {
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "Explorer (Snacks)",
		},
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>gl",
			function()
				Snacks.lazygit.log()
			end,
			desc = "Lazygit Log",
		},
		{
			"<leader>jf",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files (Snacks)",
		},
		{
			"<leader>js",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live Grep (Snacks)",
		},
		{
			"<leader>jws",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Grep Word (Snacks)",
		},
		{
			"<leader>jWs",
			function()
				Snacks.picker.grep({ search = vim.fn.expand("<cWORD>") })
			end,
			desc = "Grep WORD (Snacks)",
		},
	},
}
