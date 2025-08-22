return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			vim.cmd("TSUpdate")
		end,
		opts = {
			-- Parsers to install
			ensure_installed = {
				"python",
				"c",
				"cpp",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
			},

			-- Install parsers synchronously
			sync_install = false,

			-- Automatically install missing parsers if CLI is present
			auto_install = vim.fn.executable("tree-sitter") == 1,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,
			},
		},
		config = function(_, opts)
			local configs = require("nvim-treesitter.configs")
			configs.setup(opts)

			-- Custom parser for templ
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.templ = {
				install_info = {
					url = "https://github.com/vrischmann/tree-sitter-templ.git",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "master",
				},
				filetype = "templ", -- associate filetype
			}
		end,
	},
}
