require("albus.set")
require("albus.remap")
require("albus.lazy_init")

local augroup = vim.api.nvim_create_augroup
local Albus = augroup("Albus", {})

vim.api.nvim_create_autocmd("LspAttach", {
	group = Albus,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("n", ".d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)
		vim.keymap.set("n", ",d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)
	end,
})
