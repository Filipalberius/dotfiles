return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")

		treesitter.setup({
			install = { prefer_git = false },
		})

		local function parser_available(lang)
			return pcall(vim.treesitter.language.inspect, lang)
		end

		local function start_highlighting(bufnr, lang)
			if vim.treesitter.query.get(lang, "highlights") then
				vim.treesitter.start(bufnr, lang)
			end
		end

		local function try_install_parser(lang)
			if parser_available(lang) then
				return true
			end
			if not vim.tbl_contains(treesitter.get_available(), lang) then
				return false
			end
			treesitter.install(lang):wait()
			return parser_available(lang)
		end

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
				if try_install_parser(lang) then
					start_highlighting(ev.buf, lang)
				end
			end,
		})
	end,
}
