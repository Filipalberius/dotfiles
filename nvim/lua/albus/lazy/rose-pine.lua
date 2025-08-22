return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				extend_background_behind_borders = true,
				styles = {
					italic = false,
					transparency = true,
				},
			})

			vim.cmd.colorscheme("rose-pine")

			vim.cmd("highlight ColorColumn ctermbg=0 guibg=#6e6a86")
		end,
	},
}
